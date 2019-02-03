@enum DogState begin
    ACTIVE = 1
    OCCUPIED
    SLEEPY
end # enum
Base.length( ::DogState ) = 1
Base.iterate( ds::DogState, state = 1 ) = nothing

Base.@kwdef struct Dog{F<:Number}
    state::DogState = ACTIVE
    sleepyness::UInt32 = 0
    position::Point2{F}
    velocity::Point2{F}
end # struct

function Dog( position, velocity )
    T = eltype(position)
    @assert T == eltype(velocity)
    Dog{T}(;
        position = convert(Point2{T}, position),
        velocity = convert(Point2{T}, velocity),
        )
end # function

function Dog( v::D; kwargs... ) where D<:Dog
    nt = NamedTuple()
    for property in propertynames(v)
        if property in keys(kwargs)
            nt = merge( nt, NamedTuple{(property,)}((kwargs[property],)) )
            continue
        end
        value = getproperty( v, property )
        # if value isa Vector
        #     nt = merge( nt, NamedTuple{(property,)}(Ref(copy(value))) )
        #     continue
        # end # if
        nt = merge( nt, NamedTuple{(property,)}((value,)) )
    end
    return D(;nt...)
end # function

function move( dog::Dog, dt, motion::Motion )
    new_position, new_velocity = step( motion, dog.position, dog.velocity, dt )
    return Dog( dog; position = new_position, velocity = new_velocity )
end # function

work( d::Dog, dt ) = work( Val(d.state), d, dt )
function work( ::Val{ACTIVE}, dog::Dog, dt )
    # TODO
end # function
function work( ::Val{OCCUPIED}, dog::Dog, dt )
    # TODO
end # function
function work( ::Val{SLEEPY}, dog::Dog, dt )
    if dog.sleepyness == 0
        return Dog( dog; state = ACTIVE )
    end # if
    return Dog( dog; sleepyness = dog.sleepyness - 1 )
end # function

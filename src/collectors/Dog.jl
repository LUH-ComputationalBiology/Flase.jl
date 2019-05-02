using Distributions

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

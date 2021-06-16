using StaticArrays
struct Dogs{M<:Motion,N,D<:Dog}
    member::SizedVector{N,D}
    motion::M
end # struct

function Base.getindex( d::Dogs, i )
    return d.member[i]
end # function

function Base.getproperty( d::Dogs, s::Symbol )
    if s in fieldnames(Dogs)
        return getfield( d, s )
    else
        return Base.getproperty( d, Val(s) )
    end # if
end # function

function Base.getproperty( d::Dogs{M,N,D}, ::Val{:positions} ) where {M<:Motion,N,D<:Dog}
    T = typeof(d.member[1].position)
    # TODO: gefällt mir nicht (allocations?)
    return SizedVector{N,T}( [dog.position for dog in d.member] )
end # function

function Base.iterate(ds::Dogs, state = nothing)
    if state === nothing
        Base.iterate( ds.member )
    else
        Base.iterate( ds.member, state )
    end
end # function

function Base.length(ds::Dogs)
    Base.length( ds.member )
end # function

function Base.eltype(ds::Dogs)
    Base.eltype( ds.member )
end # function

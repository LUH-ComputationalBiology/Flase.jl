using StaticArrays
struct Dogs{M<:Motion,N,D<:Dog}
    member::SizedVector{N,D}
    motion::M
end # struct

function Base.getindex( d::Dogs, i )
    return d.member[i]
end # function

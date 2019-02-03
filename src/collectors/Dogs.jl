using StaticArrays
struct Dogs
    member::SizedVector{Int}
end # struct

function Base.getindex( d::Dogs, i )
    return d.member[i]
end # function

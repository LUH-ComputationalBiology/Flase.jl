using StaticArrays
struct Dogs{M<:Motion}
    member::SizedVector{Int}
    motion::M
end # struct

function Base.getindex( d::Dogs, i )
    return d.member[i]
end # function

function move( dogs::Dogs, dt )
    dogs.member .= move.( dogs.member, dt, Ref(dogs.motion) )
    
end # function

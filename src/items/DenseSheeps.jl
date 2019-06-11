using StaticArrays
Base.@kwdef struct DenseSheeps{L} <: Sheeps{L}
    # # TODO: gridsize needed?
    capacity::Int = 1
    # available_sheeps::Base.RefValue{Int} = Ref(0)
    current_sheep::Base.RefValue{Int} = Ref(0)
    diffusion_candidates::Vector{Tuple{Int,Int}} = Tuple{Int,Int}[]
    grid::SizedArray{Tuple{L,L},Int64,2,2} = Size(L,L)( zeros(Int,L,L) )
end

function DenseSheeps{L}( total_sheep; kwargs...  ) where L
    sheep = DenseSheeps{L}(;kwargs...)
    for _ in 1:total_sheep
        i = rand(1:L)
        j = rand(1:L)
        n_sheep = getNSheep( sheep, i, j )
        setNSheep!( sheep, i, j, n_sheep + 1 )
    end # for
    sheep.current_sheep[] = total_sheep
    kickSheep!( sheep )
    return sheep
end # function

function DenseSheeps(; gridsize, n_sheeps, kwargs...)
    return DenseSheeps{gridsize}(n_sheeps; kwargs...)
end # function

##< iterator interface
function Base.iterate( sheep::DenseSheeps{L}, state = firstindex(sheep.grid) ) where L
    for i in range(state,lastindex(sheep.grid), step = 1)
        n_sheep = sheep.grid[i]
        if n_sheep != 0
            return (n_sheep, CartesianIndices(sheep.grid)[i]), i+1
        end # if
    end # for
    return nothing
end # function

Base.eltype( sheep::DenseSheeps ) = Tuple{ Base.eltype( sheep.grid ), CartesianIndex{2} }
Base.length( sheep::DenseSheeps ) = Base.length( findall(!iszero, sheep.grid) )
##>

function _setNSheep!( sheep::DenseSheeps, i, j, n )
    old = sheep.grid[i,j]
    sheep.grid[i,j] = n
    if n > sheep.capacity
        push!( sheep.diffusion_candidates, (i,j) )
    end # if
    return old
end # function

function getNSheep( sheep::DenseSheeps, i, j )
    return sheep.grid[i,j]
end

"""
Returns random index of occupied grid-field.
"""
function getRandomSheep( sheep::DenseSheeps )
    rand( findall(!iszero, sheep.grid) )
end # function

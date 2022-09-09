using SparseArrays

Base.@kwdef struct SparseSheeps{L} <: Sheeps{L}
    capacity::Int = 1
    current_sheep::Base.RefValue{Int} = Ref(0)
    diffusion_candidates::Vector{Tuple{Int,Int}} = Tuple{Int,Int}[]
    grid::SparseMatrixCSC{Int64,Int64} = SparseMatrixCSC{Int64,Int64}(spzeros(L, L))
end

function SparseSheeps{L}(total_sheep; kwargs...) where {L}
    sheep = SparseSheeps{L}(; kwargs...)
    for _ = 1:total_sheep
        i = rand(1:L)
        j = rand(1:L)
        n_sheep = getNSheep(sheep, i, j)
        setNSheep!(sheep, i, j, n_sheep + 1)
    end # for
    sheep.current_sheep[] = total_sheep #könnte man auch weglassen
    kickSheep!(sheep)
    return sheep
end # function


function SparseSheeps(gridsize; n_sheeps, kwargs...)
    return SparseSheeps{gridsize}(n_sheeps; kwargs...)
end # function


function Base.iterate(sheep::SparseSheeps{L}, state = firstindex(sheep.grid)) where {L}
    for i in range(state, lastindex(sheep.grid), step = 1)
        n_sheep = sheep.grid[i]
        if n_sheep != 0
            return (n_sheep, CartesianIndices(sheep.grid)[i]), i + 1
        end # if
    end # for
    return nothing #könnte man auch weglassen
end # function

#element type
Base.eltype(sheep::SparseSheeps) = Tuple{Base.eltype(sheep.grid),CartesianIndex{2}}
Base.length(sheep::SparseSheeps) = Base.length(findall(!iszero, sheep.grid))


function _setNSheep!(sheep::SparseSheeps, i, j, n)
    old = sheep.grid[i, j]
    sheep.grid[i, j] = n
    if n > sheep.capacity
        push!(sheep.diffusion_candidates, (i, j))
    end # if
    return old
end # function

function getNSheep(sheep::SparseSheeps, i, j)
    return sheep.grid[i, j]
end

"""
Returns random index of occupied grid-field.
"""
function getRandomSheep(sheep::SparseSheeps)
    rand(findall(!iszero, sheep.grid))
end # function

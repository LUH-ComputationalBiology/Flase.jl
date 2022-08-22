Base.@kwdef struct BaseSheeps{L} <: Sheeps{L}
    capacity::Int = 1
    current_sheep::Base.RefValue{Int} = Ref(0)
    diffusion_candidates::Vector{Tuple{Int,Int}} = Tuple{Int,Int}[]
    grid::Matrix{Int} = zeros(Int,L,L)
end

function BaseSheeps{L}( total_sheep; kwargs...  ) where L
    sheep = BaseSheeps{L}(;kwargs...)
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

# Vereinfachte Eingabeversion des Konstruktors
function BaseSheeps(gridsize; n_sheeps, kwargs...)
    return BaseSheeps{gridsize}(n_sheeps; kwargs...)
end # function

##< iterator interface (erlaubt iterieren (zB for schleife) über Struktur Sheep)
function Base.iterate( sheep::BaseSheeps, state = firstindex(sheep.grid) )
    for i in range(state,lastindex(sheep.grid), step = 1)
        n_sheep = sheep.grid[i]
        if n_sheep != 0
            return (n_sheep, CartesianIndices(sheep.grid)[i]), i+1
        end # if
    end # for
    return nothing
end # function

#element type
Base.eltype( sheep::BaseSheeps ) = Tuple{ Base.eltype( sheep.grid ), CartesianIndex{2} }
Base.length( sheep::BaseSheeps ) = Base.length( findall(!iszero, sheep.grid) )
##>

function _setNSheep!( sheep::BaseSheeps, i, j, n )
    old = sheep.grid[i,j]
    sheep.grid[i,j] = n
    if n > sheep.capacity
        push!( sheep.diffusion_candidates, (i,j) )
    end # if
    return old
end # function

function getNSheep( sheep::BaseSheeps, i, j )
    return sheep.grid[i,j]
end

"""
Returns random index of occupied grid-field.
"""
function getRandomSheep( sheep::BaseSheeps )
    rand( findall(!iszero, sheep.grid) )
end # function

function gridsize( sheep::BaseSheeps )
    return size(sheep.grid)[1]
end

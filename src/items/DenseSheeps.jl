using StaticArrays
Base.@kwdef struct DenseSheeps{L} <: Sheeps{L}
    # # TODO: gridsize needed?
    # capacity: wie viele Schafe passen auf einen Gitterplatz (default 1)
    capacity::Int = 1
    # available_sheeps::Base.RefValue{Int} = Ref(0)
    # current: wie viele gibt es insgesamt?
    current_sheep::Base.RefValue{Int} = Ref(0)
    # hier kommen Schafe hin, wenn capacity besetzt ist, einfach ein freier Platz
    diffusion_candidates::Vector{Tuple{Int,Int}} = Tuple{Int,Int}[]
    # matrix die anzeigt, wo jemand sitzt (Am Anfang nur 0)
    grid::SizedArray{Tuple{L,L},Int64,2,2} = SizedMatrix{L,L}(zeros(Int, L, L))
end

# Konstruktor, generiert erstmal die Schafe und setzt sie irgendwo hin
function DenseSheeps{L}(total_sheep; kwargs...) where {L}
    sheep = DenseSheeps{L}(; kwargs...)
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

# Vereinfachte Eingabeversion des Konstruktors
function DenseSheeps(gridsize; n_sheeps, kwargs...)
    return DenseSheeps{gridsize}(n_sheeps; kwargs...)
end # function

##< iterator interface (erlaubt iterieren (zB for schleife) über Struktur Sheep)
function Base.iterate(sheep::DenseSheeps{L}, state = firstindex(sheep.grid)) where {L}
    for i in range(state, lastindex(sheep.grid), step = 1)
        n_sheep = sheep.grid[i]
        if n_sheep != 0
            return (n_sheep, CartesianIndices(sheep.grid)[i]), i + 1
        end # if
    end # for
    return nothing #könnte man auch weglassen
end # function

#element type
Base.eltype(sheep::DenseSheeps) = Tuple{Base.eltype(sheep.grid),CartesianIndex{2}}
Base.length(sheep::DenseSheeps) = Base.length(findall(!iszero, sheep.grid))
##>

function _setNSheep!(sheep::DenseSheeps, i, j, n)
    old = sheep.grid[i, j]
    sheep.grid[i, j] = n
    if n > sheep.capacity
        push!(sheep.diffusion_candidates, (i, j))
    end # if
    return old
end # function

function getNSheep(sheep::DenseSheeps, i, j)
    return sheep.grid[i, j]
end

"""
Returns random index of occupied grid-field.
"""
function getRandomSheep(sheep::DenseSheeps)
    rand(findall(!iszero, sheep.grid))
end # function

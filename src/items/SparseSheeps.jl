Base.@kwdef struct SparseSheeps{L} <: Sheeps
    gridsize::Int
    capacity::Int
    available_sheeps::Int = 0
end

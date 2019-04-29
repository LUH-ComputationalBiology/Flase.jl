using StaticArrays
#Base.@kwdef
struct DenseSheeps{L} <: Sheeps{L}
    # # TODO: gridsize needed?
    gridsize::Int# = L
    capacity::Int# = 1
    available_sheeps::Int# = 0
    grid::SizedArray{Tuple{L,L},Int64,2,2}
end

DenseSheeps(; gridsize = 10, capacity = 1, available_sheeps = 0 ) = DenseSheeps{gridsize}( gridsize, capacity, available_sheeps, Size(gridsize,gridsize)( zeros(Int,gridsize,gridsize) ) )

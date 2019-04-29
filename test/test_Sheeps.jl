using Flase
using Test
using StaticArrays

@testset "Dense Sheeps" begin
    sheep = Flase.DenseSheeps()
    @testset "Defaults" begin
        @test sheep.gridsize == 10
        @test sheep.capacity == 1
        @test sheep.available_sheeps == 0
        @test sheep.grid == Size(10,10)(zeros(Int,10,10))
    end # testset
end # testset

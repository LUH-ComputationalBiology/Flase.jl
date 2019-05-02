using Flase
using Test
using StaticArrays

@testset "Dense Sheeps" begin
    sheep = Flase.DenseSheeps{10}()
    sheep10 = Flase.DenseSheeps{10}(10)
    zero_grid = Size(10,10)(zeros(Int,10,10))
    @testset "Defaults" begin
        @test sheep.capacity == 1
        @test sheep.available_sheeps[] == 0
        @test sheep.current_sheep[] == 0
        @test sheep.grid == zero_grid
        @test sheep10.current_sheep[] == 10
        @test sheep10.grid != zero_grid
    end # testset

    @testset "Get/Set" begin
        @test Flase._setNSheep!( sheep, 1, 2, 1 ) == 0
        @test isempty(sheep.diffusion_candidates) == true
        @test sheep.grid[1,2] == 1
        @test Flase._setNSheep!( sheep, 1, 2, 2 ) == 1
        @test sheep.diffusion_candidates[1] == (1,2)
    end # testset
end # testset

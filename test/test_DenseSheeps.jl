using Flase, Test

n_sheeps = 10
sheeps = DenseSheeps(10, n_sheeps = n_sheeps)
@testset "Diffusion" begin
    @test sheeps.grid[Flase.getRandomSheep(sheeps)] != 0
    for (n, coords) in sheeps
        @test Flase.getNSheep(sheeps, Tuple(coords)...) == n
    end # for
    (n, coords) = first(sheeps)
    @test Flase.setNSheep!(sheeps, Tuple(coords)..., sheeps.capacity + 1) == nothing
    @test sheeps.grid[coords] == sheeps.capacity + 1
    @test sheeps.diffusion_candidates == [Tuple(coords)]
    @test Flase.kickSheep!(sheeps) == nothing
    @test sheeps.diffusion_candidates |> isempty == true
    @test sheeps.current_sheep[] == n_sheeps + sheeps.capacity - n + 1
end # testset

using Flase, Test

world = World(
    v0 = 1.0,
    n_dogs = 120,
    boxsize = 10.0,
    motion = BrownianMotion(noise = 0.5, friction = 1.0),
    sheeps = DenseSheeps(10, n_sheeps = 10),
)
@testset "Test iteration" begin
    @test iterate(world.dogs)[2][2] == 1
    @test iterate(world.dogs, iterate(world.dogs)[2])[2][2] == 2
end # testset

using Flase, Test

world = World(
    v0 = 1.,
    n_dogs = 120,
    boxsize = 10.0,
    motion = BrownianMotion(
        noise = 0.5,
        friction = 1.0
        ),
    sheeps = DenseSheeps(
        n_sheeps = 10,
        gridsize = 10,
        )
    )
simulation = FiniteSimulation(;
    dt = 0.2,
    end_time = 100.0,
    world = world,
    plotter = UnicodePlotter()
    )

@testset "Move items" begin
    @test simulation.time[] < simulation.t_sheep_boredom[]
    @test Flase.move_sheep!( simulation ) == false
    simulation.time[] = simulation.t_sheep_boredom[] + 1
    @test Flase.move_sheep!( simulation ) == true
    simulation.time[] = zero( simulation.time[] )
end # testset

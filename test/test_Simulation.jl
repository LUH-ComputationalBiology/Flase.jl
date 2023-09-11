using Flase, Test

world = World(
    v0=1.0,
    n_dogs=120,
    boxsize=10.0,
    motion=BrownianMotion(noise=0.5, friction=1.0),
    sheeps=DenseSheeps(10, n_sheeps=10),
)

simulation = FiniteSimulation(;
    dt=0.2,
    end_time=100.0,
    world=world,
    plotter=UnicodePlotter()
)

@testset "Move items" begin
    old_grid = copy(simulation.world.sheeps.grid)
    @test simulation.time[] < simulation.t_sheep_boredom[]
    @test Flase.move_sheep!(simulation) == false
    simulation.time[] = simulation.t_sheep_boredom[] + 1
    @test Flase.move_sheep!(simulation) == true
    simulation.time[] = zero(simulation.time[])
    @test old_grid != simulation.world.sheeps.grid
end # testset

@testset "Interactions" begin
    pos = simulation.world.dogs.member[3].position
    @test all(pos .< Flase.getSheepCoords(simulation.world, pos))
end


world2 = World(
    v0=1.0,
    n_dogs=10,
    boxsize=25.0,
    motion=BrownianMotion(noise=0.5, friction=1.0),
    sheeps=DenseSheeps(30, n_sheeps=30),
)

simulation2 = Flase.ClusterTimeSimulation(;
    condition=0,
    dt=0.2,
    world=world2,
    plotter=Flase.VoidPlotter()
)

simulation3 = Flase.ClusterTimeSimulation(;
    condition=1,
    dt=0.2,
    world=world,
    plotter=Flase.VoidPlotter()
)

@testset "ClusterTimeSimulation" begin
    mqd = Flase.MQD(simulation2.world.sheeps)
    msd = Flase.MSD()
    @show Flase.runsim(simulation2)
    @show Flase.runsim(simulation3)
    @test Flase.getMSD(msd, simulation2.world.sheeps, simulation2.world) >= 0.7
    @test Flase.getMQD(mqd, simulation3.world.sheeps) <= 0.1
end

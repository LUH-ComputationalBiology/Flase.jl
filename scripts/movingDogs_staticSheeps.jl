using Flase

v0 = 5.0
Dϕ = 4.0
world = World(
    v0 = 1.,
    n_dogs = 100,
    boxsize = 250.0,
    freedom_rate = 10.0,
    business_rate = 10.0,
    meanSleepyness = 10.0,
    motion = BrownianMotion(
        noise = v0^4 / Dϕ,
        friction = Dϕ / v0^2
        ),
    sheeps = DenseSheeps(
        n_sheeps = 200,
        gridsize = 250,
        )
    )
simulation = FiniteSimulation(;
    dt = 0.1,
    end_time = 1.0,
    world = world,
    plotter = UnicodePlotter()
    )
    # TODO: get this smooth
# simulation = FiniteSimulation(;
#     dt = 0.1,
#     end_time = 20_000.0,
#     world = world,
#     plotter = UnicodePlotter( skip = 2_000 )
#     )
Juno.@profiler Flase.runsim( simulation )

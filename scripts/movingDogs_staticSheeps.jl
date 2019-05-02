using Flase

world = World(
    v0 = 1.,
    n_dogs = 120,
    boxsize = 10.0,
    motion = BrownianMotion(
        noise = 0.5,
        friction = 1.0
        ),
    sheeps = DenseSheeps{10}(10)
    )
simulation = FiniteSimulation(;
    dt = 0.1,
    end_time = 1.0,
    world = world,
    plotter = UnicodePlotter()
    )
Flase.runsim( simulation )

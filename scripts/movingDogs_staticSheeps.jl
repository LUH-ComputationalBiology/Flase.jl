using Flase

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
Flase.runsim( simulation )

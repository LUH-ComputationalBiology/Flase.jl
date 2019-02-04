using Flase

dog = Flase.Dog([1.,2.],[1.,0.])
motion = Flase.ConstVelocity( 0.5, 1. )
world = World(
    v0 = 1.,
    n_dogs = 10,
    boxsize = 10.0,
    motion = Flase.BrownianMotion(
        noise = 0.5,
        friction = 1.0
        )
    )
world.dogs.positions

using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using Flase
using BenchmarkTools

@time begin
    v0 = 5.0
    Dϕ = 4.0
    gridsize = 10
    frac = 0.1
    world = World(
        v0 = 1.0,
        n_dogs = 9,
        boxsize = float(gridsize),
        freedom_rate = 10.0,
        business_rate = 10.0,
        meanSleepyness = 10.0,
        motion = BrownianMotion(noise = v0^4 / Dϕ, friction = Dϕ / v0^2),
        sheeps = DenseSheeps(
            gridsize, # gridsize
            n_sheeps = frac * gridsize^2,
        ),
    )
    simulation = FiniteSimulation(;
        dt = 0.1,
        end_time = 100.0,
        world = world,
        plotter = Flase.VoidPlotter(),
    )
end
@benchmark begin
    Flase.runsim(simulation)
end samples = 1 evals = 1 gcsample = true

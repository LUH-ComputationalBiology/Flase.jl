using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using Flase
using BenchmarkTools

println("gridsize, fraction, time, bytes")
for gridsize in (10, 20, 100, 200, 400, 800) #=1600, 2000=#
    for sheep_ration in (0.1, 0.5, 0.9)
        t = @timed begin
            v0 = 5.0
            Dϕ = 4.0
            world = World(
                v0 = 1.0,
                n_dogs = 9,
                boxsize = float(gridsize),
                freedom_rate = 10.0,
                business_rate = 10.0,
                meanSleepyness = 10.0,
                motion = BrownianMotion(noise = v0^4 / Dϕ, friction = Dϕ / v0^2),
                sheeps = Flase.SparseSheeps(
                    gridsize, # gridsize
                    n_sheeps = sheep_ration * gridsize^2,
                ),
            )
            simulation = FiniteSimulation(;
                dt = 0.1,
                end_time = 100.0,
                world = world,
                plotter = Flase.VoidPlotter(),
            )
        end
        println("$gridsize, $sheep_ration, $(t.time), $(t.bytes)")
    end
end

using Distributions

struct FiniteSimulation{F<:Number,W<:World, P<:Plotter} <: Simulation
    time::Base.RefValue{F}
    t_sheep_boredom::Base.RefValue{F}
    dt::F
    end_time::F
    world::W
    plotter::P
end

FiniteSimulation(;
    time = 0.0,
    dt::F,
    end_time = 10.0,
    world::W,
    t_sheep_boredom = rand(Exponential(world.meanSheepDiffusionTime / world.sheeps.current_sheep[])),
    plotter::P = VoidPlotter()
    ) where {F<:Number,W<:World,P<:Plotter} = FiniteSimulation{F,W,P}( Ref(time), Ref(t_sheep_boredom), dt, end_time, world, plotter )

function runsim( sim::FiniteSimulation )
    p = plot( sim.plotter, sim.world, sim.time[] )
    io = IOBuffer()
    print(io, "\e[25l")
    # try
        for _ in 0:sim.end_time÷sim.dt
            iterate( sim )
            sim.time[] += sim.dt

            plot!( io, p, sim.plotter, sim.world, sim.time[] )
        end # while
    # catch err
    #     @error "Caught $err !"
    #     rethrow( err )
    # finally
        print(io, "\e[25h")
        endtime = sim.time[]
        sim.time[] = zero(sim.time[])
        return endtime
    # end # try
end # function

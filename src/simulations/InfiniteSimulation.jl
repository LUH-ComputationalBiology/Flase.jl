
struct InfiniteSimulation{F<:Number,W<:World, P<:Plotter} <: Simulation
    time::Base.RefValue{F}
    dt::F
    world::W
    plotter::P
end

InfiniteSimulation(; time = Ref(0.0), dt::F, world::W, plotter::P = VoidPlotter() ) where {F<:Number,W<:World,P<:Plotter} = InfiniteSimulation{F,W,P}( time, dt, world, plotter )

function runsim( sim::InfiniteSimulation )
    p = plot( sim.plotter, sim.world, sim.time[] )
    display(p)
    while true
        iterate( sim )
        sim.time[] += sim.dt

        p = plot!( p, sim.plotter, sim.world, sim.time[] )
        display(p)
        sleep( 0.1 )
    end # while
    endtime = sim.time[]
    sim.time[] = zero(sim.time[])
    return endtime
end # function

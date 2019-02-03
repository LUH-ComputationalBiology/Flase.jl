Base.@kwdef struct InfiniteSimulation{F<:Number,W<:World, P<:Plotter} <: Simulation
    time::Base.RefValue{F} = Ref(zero(F))
    dt::F
    world::W
    plotter::P
end

function run( sim::InfiniteSimulation )
    while true
        iterate( sim, world, dt )
        sim.time[] += sim.dt

        Flase.plot( sim.plotter, sim.world, sim.time[] )
    end # while
    return sim.time[]
end # function

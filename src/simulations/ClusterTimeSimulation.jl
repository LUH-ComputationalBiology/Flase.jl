using Distributions

struct ClusterTimeSimulation{P<:Plotter, F<:Number, W<:World } <: Simulation 

    time::Base.RefValue{F}
    t_sheep_boredom::Base.RefValue{F}
    condition::Int64
    msdThreshold::Float64
    mqdThreshold::Float64
    dt::F
    world::W
    plotter::P

end 

ClusterTimeSimulation(;

    msdThreshold::Float64 = 0.7,
    mqdThreshold::Float64 = 0.1,
    dt::F,
    world::W,
    condition::Int64,
    time::F = convert(typeof(dt), 0) ,
    t_sheep_boredom = rand(Exponential(world.meanSheepDiffusionTime / world.sheeps.current_sheep[])),
    plotter::P = VoidPlotter()
) where {F<:Number, W<:World,P<:Plotter} = ClusterTimeSimulation{P,F,W}(Ref(time), Ref(t_sheep_boredom), condition, msdThreshold, mqdThreshold, dt, world, plotter) 


function runsim(sim::ClusterTimeSimulation)
 mq = MQD(1.)
 ms = MSD(1.)
p = plot( sim.plotter, sim.world, sim.time[] )
    io = IOBuffer()
if sim.condition == 0
    while mq.mqd > sim.mqdThreshold

        Flase.measure( mq ,sim.world.sheeps)
        iterate!( sim )
        plot!( io, p, sim.plotter, sim.world, sim.time[] )
        println(mq.mqd)
    end
elseif sim.condition == 1
    while ms.msd > sim.msdThreshold

        Flase.measure( mq ,sim.world.sheeps)
        iterate!( sim )
        plot!( io, p, sim.plotter, sim.world, sim.time[] )

    end
elseif sim.condition == 2
    while ms.msd < sim.msdThreshold && mq.mqd > sim.mqdThreshold

        Flase.measure( mq ,sim.world.sheeps)
        iterate!( sim )
        plot!( io, p, sim.plotter, sim.world, sim.time[] )

    end
else sim.condition == 3
println("this is condition 3")
end
return sim.time[]
end

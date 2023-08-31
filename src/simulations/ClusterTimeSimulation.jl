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
    plotter::P = UnicodePlotter()
) where {F<:Number, W<:World,P<:Plotter} = 
    ClusterTimeSimulation{P,F,W}(Ref(time), Ref(t_sheep_boredom), condition, msdThreshold, mqdThreshold, dt, world, plotter) 


function runsim(sim::ClusterTimeSimulation)
mqd = MQD()
msd = MSD()
mqdNorm = measure(mqd, sim.world.sheeps)
p = plot(sim.plotter, sim.world, sim.time[])
io = IOBuffer()
if sim.condition == 0
    while msd < msdThreshold

        measure(msd, sim.world.sheeps)
        iterate!(sim)
        plot!(io, p, sim.plotter, sim.world, sim.time[])

    end
elseif sim.condition == 1
    while getMQD(mqd, sim.world.sheeps, mqdNorm) > sim.mqdThreshold

        measure(mqd, sim.world.sheeps)
        iterate!(sim)
        plot!(io, p, sim.plotter, sim.world, sim.time[])

    end
elseif sim.condition == 2
    while ms.msd < sim.msdThreshold && getMQD(mqd, sim.world.sheeps, mqdNorm) > sim.mqdThreshold

        measure(mqd, sim.world.sheeps)
        iterate!(sim)
        plot!(io, p, sim.plotter, sim.world, sim.time[])

    end
else sim.condition == 3
error("Check breaking condition! It is $condition right now.")

end

return sim.time[]

end

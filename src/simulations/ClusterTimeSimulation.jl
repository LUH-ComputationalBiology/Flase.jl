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
mqd_value = getMQD(mqd, sim.world.sheeps, mqdNorm)
msd_value = getMSD(msd, sim.world.sheeps, sim.world)

p = plot(sim.plotter, sim.world, sim.time[])
io = IOBuffer()
if sim.condition == 0
    while msd_value < sim.msdThreshold

        println("I'm in 1")
        measure(msd, sim.world.sheeps)
        iterate!(sim)
        plot!(io, p, sim.plotter, sim.world, sim.time[])
        msd_value = getMSD(msd, sim.world.sheeps, sim.world)

    end
elseif sim.condition == 1
    while mqd_value > sim.mqdThreshold

        println("I'm in 2")
        measure(mqd, sim.world.sheeps)
        iterate!(sim)
        plot!(io, p, sim.plotter, sim.world, sim.time[])
        mqd_value = getMQD(mqd, sim.world.sheeps, mqdNorm)

    end
elseif sim.condition == 2
    while msd_value < sim.msdThreshold && mqd_value > sim.mqdThreshold

        println("I'm in 3")
        measure(mqd, sim.world.sheeps)
        iterate!(sim)
        plot!(io, p, sim.plotter, sim.world, sim.time[])
        mqd_value = getMQD(mqd, sim.world.sheeps, mqdNorm)
        msd_value = getMSD(msd, sim.world.sheeps, sim.world)

    end
else sim.condition == 3
error("Check breaking condition! It is $condition right now.")

end

return sim.time[]

end

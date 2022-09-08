using Distributions

struct InfiniteSimulation{F<:Number,W<:World,P<:Plotter} <: Simulation
    time::Base.RefValue{F}
    t_sheep_boredom::Base.RefValue{F}
    dt::F
    world::W
    plotter::P
end

InfiniteSimulation(;
    time = 0.0,
    dt::F,
    world::W,
    t_sheep_boredom = rand(
        Exponential(world.meanSheepDiffusionTime / world.sheeps.current_sheep[]),
    ),
    plotter::P = VoidPlotter(),
) where {F<:Number,W<:World,P<:Plotter} =
    InfiniteSimulation{F,W,P}(Ref(time), Ref(t_sheep_boredom), dt, world, plotter)

function runsim(sim::InfiniteSimulation)
    p = plot(sim.plotter, sim.world, sim.time[])
    io = IOBuffer()
    print(io, "\e[25l")
    @sync begin
        is_running = Base.RefValue(true)
        @async begin
            readavailable(stdin)
            is_running[] = false
            return nothing
        end # async
        @async begin
            while is_running[]
                iterate!(sim)

                plot!(io, p, sim.plotter, sim.world, sim.time[])
            end # while
        end # async
    end # sync
    print(io, "\e[25h")
    endtime = sim.time[]
    sim.time[] = zero(sim.time[])
    return endtime
end # function

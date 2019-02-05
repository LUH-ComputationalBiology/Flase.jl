
struct InfiniteSimulation{F<:Number,W<:World, P<:Plotter} <: Simulation
    time::Base.RefValue{F}
    dt::F
    world::W
    plotter::P
end

InfiniteSimulation(; time = Ref(0.0), dt::F, world::W, plotter::P = VoidPlotter() ) where {F<:Number,W<:World,P<:Plotter} = InfiniteSimulation{F,W,P}( time, dt, world, plotter )

function runsim( sim::InfiniteSimulation )
    p = plot( sim.plotter, sim.world, sim.time[] )
    io = IOBuffer()
    print(io, "\e[25l")
    print(io, "\e[2K\e[1F")
    @sync begin
    is_running = Base.RefValue(true)
    @async begin
        readavailable(stdin)
        is_running[] = false
        return nothing
    end # async
    @async while is_running[]
            iterate( sim )
            sim.time[] += sim.dt

            plot!( io, p, sim.plotter, sim.world, sim.time[] )
        end # while
    end # sync
    print(io, "\e[25h")
    endtime = sim.time[]
    sim.time[] = zero(sim.time[])
    return endtime
end # function

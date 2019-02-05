import UnicodePlots
using StaticArrays

struct UnicodePlotter{T<:Number} <: Plotter;
    fps::T
end

function UnicodePlotter(; fps = 20)
    UnicodePlotter{typeof(fps)}(fps)
end # function

function plot( ::UnicodePlotter, world::World, time )
    positions = world.dogs.positions
    xs = map( p->p[1], positions )
    ys = map( p->p[2], positions )
    p = UnicodePlots.scatterplot( xs, ys,
        xlim = @SVector([0, world.boxsize[]]),
        ylim = @SVector([0, world.boxsize[]])
        )
    display(p)
    return p
end # function

function plot!( io, p, plotter::UnicodePlotter, world::World, time )
    for _ in 1:(UnicodePlots.nrows( p.graphics )+p.margin)
        print(io, "\e[2K\e[1F")
    end # for
    positions = world.dogs.positions
    xs = map( p->p[1], positions )
    ys = map( p->p[2], positions )
    p = UnicodePlots.scatterplot( xs, ys,
        xlim = @SVector([0, world.boxsize[]]),
        ylim = @SVector([0, world.boxsize[]])
        )
    show(IOContext(io, :color => true), p)
    print(io,"\n\t\tPress Enter twice to end simulation.")
    print(stdout, String(take!(io)))
    sleep( 1 / plotter.fps )
    return nothing
end # function

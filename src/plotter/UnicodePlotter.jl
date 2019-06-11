import UnicodePlots
using StaticArrays

struct UnicodePlotter{T<:Number} <: Plotter;
    fps::T
end

function UnicodePlotter(; fps = 20)
    UnicodePlotter{typeof(fps)}(fps)
end # function

function plot( ::UnicodePlotter, world::World, time )
    active_dogs = filter( d->(d.state==ACTIVE), world.dogs.member )
    sleepy_dogs = typeof(world.dogs.member)[]
    occupied_dogs = typeof(world.dogs.member)[]
    if length( active_dogs ) < length( world.dogs )
        sleepy_dogs = filter( d->(d.state==SLEEPY), world.dogs.member )
        occupied_dogs = filter( d->(d.state==OCCUPIED), world.dogs.member )
    end
    p = UnicodePlots.scatterplot( Float64[],
            xlim = @SVector([0, world.boxsize[]]),
            ylim = @SVector([0, world.boxsize[]])
            )
    for data in ( (active_dogs,:green), (sleepy_dogs,:red), (occupied_dogs,:white) )
        positions = getproperty.( data[1], :position )
        xs = map( p->p[1], positions )
        ys = map( p->p[2], positions )
        p = UnicodePlots.scatterplot!( p, xs, ys, color = data[2] )
    end # for
    sheeps = collect( world.sheeps )
    sheep_xs = map( s->s[2][1], sheeps )
    sheep_ys = map( s->s[2][2], sheeps )
    UnicodePlots.scatterplot!( p, sheep_xs, sheep_ys )
    return p
end # function

function plot!( io, p, plotter::UnicodePlotter, world::World, time )
    for _ in 1:(UnicodePlots.nrows( p.graphics )+p.margin)
        print(io, "\e[2K\e[1F")
    end # for
    p = plot( plotter, world, time )
    show(IOContext(io, :color => true), p)
    print(io,"\n\t\tPress Enter twice to end simulation.")
    print(stdout, String(take!(io)))
    sleep( 1 / plotter.fps )
    return nothing
end # function

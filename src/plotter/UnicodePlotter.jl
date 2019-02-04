using UnicodePlots
struct UnicodePlotter <: Plotter; end

function plot( ::UnicodePlotter, world::World, time )
    positions = world.dogs.positions
    xs = map( p->p[1], positions )
    ys = map( p->p[2], positions )
    display( UnicodePlots.plot( xs, ys ) )
    return nothing
end # function

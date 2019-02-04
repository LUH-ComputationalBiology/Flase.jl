import UnicodePlots
import REPL
import REPL.Terminals

struct UnicodePlotter <: Plotter; end

function plot( ::UnicodePlotter, world::World, time )
    positions = world.dogs.positions
    xs = map( p->p[1], positions )
    ys = map( p->p[2], positions )
    return UnicodePlots.scatterplot( xs, ys )
end # function
function plot!( p, ::UnicodePlotter, world::World, time )
    term = Base.active_repl.t
    for _ in 1:(UnicodePlots.nrows( p.graphics )+p.margin)
        REPL.Terminals.clear_line(term)
        REPL.cmove_up(term)
    end # for
    positions = world.dogs.positions
    xs = map( p->p[1], positions )
    ys = map( p->p[2], positions )
    return UnicodePlots.scatterplot( xs, ys )
end # function

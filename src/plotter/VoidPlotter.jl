struct VoidPlotter <: Plotter
end

plot( ::VoidPlotter, world::World, time ) = nothing
plot!( io, p, ::VoidPlotter, world::World, time ) = nothing

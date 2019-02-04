struct VoidPlotter <: Plotter
end

plot( ::VoidPlotter, world::World, time ) = nothing

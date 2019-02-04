abstract type Simulation end

function iterate( sim::Simulation )
    move_dogs!( sim.world, sim.dt )
    # TODO: move_sheep
    # TODO: work( world.dogs[] )
end # function

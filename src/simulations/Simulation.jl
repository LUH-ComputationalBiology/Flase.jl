abstract type Simulation end

function iterate( sim::Simulation, world::World, dt )
    move( world.dogs, dt )
    # TODO: move_sheep
    # TODO: work( world.dogs[] )
end # function

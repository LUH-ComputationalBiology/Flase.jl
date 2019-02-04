abstract type Simulation end

function iterate( sim::Simulation, dt )
    move( sim.world.dogs, dt )
    # TODO: move_sheep
    # TODO: work( world.dogs[] )
end # function

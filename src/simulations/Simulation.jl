abstract type Simulation end

function iterate!( sim::Simulation )
    move_dogs!( sim.world, sim.dt )
    move_sheep!( sim )
    work!( sim.world, sim.dt )
    sim.time[] += sim.dt
end # function

function move_sheep!( sim::Simulation )
    if sim.time[] >= sim.t_sheep_boredom[]
        i,j = Tuple(getRandomSheep( sim.world.sheeps ))
        diffuseSheep!( sim.world.sheeps, i, j )

        sim.t_sheep_boredom[] = sim.time[] +
            rand(
                Exponential(
                    sim.world.meanSheepDiffusionTime / sim.world.sheeps.current_sheep[]
                    )
                )

        kickSheep!( sim.world.sheeps )
        return true
    end # if
    return false
end # function

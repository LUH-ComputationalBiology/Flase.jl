abstract type Simulation end

function iterate( sim::Simulation )
    move_dogs!( sim.world, sim.dt )
    move_sheep!( sim )
    work!( sim.world, sim.dt )
end # function

function move_sheep!( sim::Simulation )
    if sim.time[] >= sim.t_sheep_boredom[]
        i,j = getRandomSheep( sim.world.sheep )
        diffuseSheep!( sim.world.sheep, i, j )

        t_sheep_boredom[] = time[] + rand(Exponential(world.meanSheepDiffusionTime / world.sheep.current_sheep[]))

        kickSheep!( sim.world.sheep )
        return true
    end # if
    return false
end # function

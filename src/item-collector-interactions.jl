##< work
work!(world::World, d::Dog, dt) = work!(world, Val(d.state), d, dt)

function work!(world, ::Val{ACTIVE}, dog::Dog, dt)
    i, j = getSheepCoords(world, dog.position)
    n_sheep = getNSheep(world.sheeps, i, j)
    n_sheep == 0 && return dog
    if rand() < n_sheep * world.business_rate * dt
        # pick up a sheep
        setNSheep!(world.sheeps, i, j, n_sheep - 1)
        return Dog(dog, state = OCCUPIED)
    end # if
    return dog
end # function

function work!(world, ::Val{OCCUPIED}, dog::Dog, dt)
    i, j = getSheepCoords(world, dog.position)
    n_sheep = getNSheep(world.sheeps, i, j)
    n_sheep == 0 && return dog
    if rand() < n_sheep * world.freedom_rate * dt
        # drop a sheep
        setNSheep!(world.sheeps, i, j, n_sheep + 1)
        return Dog(
            dog;
            state = SLEEPY,
            sleepyness = rand(Exponential(world.meanSleepyness)) ÷ dt,
        )
    end # if
    return dog
end # function

function work!(world, ::Val{SLEEPY}, dog::Dog, dt)
    if dog.sleepyness == 0
        return Dog(dog; state = ACTIVE)
    end # if
    return Dog(dog; sleepyness = dog.sleepyness - 1)
end # function
##> work

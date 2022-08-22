# Dog <-> World
function move( dog::Dog, world::World, dt, motion::Motion )
    new_position, new_velocity = step( motion, dog.position, dog.velocity, dt )
    new_position = pbc( new_position, world )
    return Dog( dog; position = new_position, velocity = new_velocity )
end # function

function move_dogs!( world::World, dt )
    dogs = world.dogs
    dogs.member .= move.( dogs.member, Ref(world), dt, Ref(dogs.motion) )
    return nothing
end # function

# Sheeps <-> World

function center_of_mass( sheeps::Sheeps{L}, world::World) where L
    r = L / 2pi
    xt1 = 0
    xt2 = 0
    yt1 = 0
    yt2 = 0
    for (n, ci) in sheeps
        i, j = Tuple(ci)
        xt1 += n * cos( i / r)
        yt1 += n * sin( i / r)

        xt2 += n * cos( j / r)
        yt2 += n * sin( j / r)
    end

    phi1 = if xt1 == 0 && yt1 == 0
        2pi * rand()
    else
        atan(yt1, xt1)
    end
    if phi1 < 0
        phi1 += 2pi
    end

    phi2 = if xt2 == 0 && yt2 == 0
        2pi * rand()
    else
        atan(yt2, xt2)
    end
    if phi2 < 0
        phi2 += 2pi
    end
    return (phi1 * world.boxsize[] / 2pi, phi2 * world.boxsize[] / 2pi)
end

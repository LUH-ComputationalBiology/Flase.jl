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

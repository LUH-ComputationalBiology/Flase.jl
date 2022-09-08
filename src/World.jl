using StaticArrays
using GeometryTypes

struct World{F<:Number,D<:Dogs,S<:Sheeps}
    boxsize::Base.RefValue{F}
    business_rate::F
    freedom_rate::F
    meanSleepyness::F
    meanSheepDiffusionTime::F
    dogs::D
    sheeps::S
end

function World(;
    v0 = 0,
    n_dogs = 0,
    boxsize::F = 0.0,
    business_rate::F = 20.0,
    freedom_rate::F = 20.0,
    meanSleepyness::F = 0.1,
    meanSheepDiffusionTime::F = 1000.0,
    motion::M = BrownianMotion(),
    sheeps = DenseSheeps{convert(Int, boxsize)}(10),
) where {F<:Number,M<:Motion}
    dogvec = SizedArray{Tuple{n_dogs},Dog{F}}(undef)
    @inbounds for i = 1:n_dogs
        ϕ = 2π * rand()
        dogvec[i] = Dog(Point2{F}(boxsize .* rand(2)), Point2{F}(v0 .* [cos(ϕ), sin(ϕ)]))
    end # for
    dogs = Dogs{M,n_dogs,Dog{F}}(dogvec, motion)
    return World{F,typeof(dogs),typeof(sheeps)}(
        Ref(boxsize),
        business_rate,
        freedom_rate,
        meanSleepyness,
        meanSheepDiffusionTime,
        dogs,
        sheeps,
    )
end # function

function pbc(position::P, world::World) where {P}
    p = position
    boxsize = world.boxsize[]
    tx = mod(p[1], boxsize)
    ty = mod(p[2], boxsize)
    while tx < 0
        tx += boxsize
    end
    while ty < 0
        ty += boxsize
    end

    return P(tx, ty)
end # function

function getSheepCoords(world::World{<:Number,<:Dogs,<:Sheeps{L}}, position) where {L}
    x, y = position
    i = convert(typeof(L), (x * L) ÷ world.boxsize[]) + 1
    j = convert(typeof(L), (y * L) ÷ world.boxsize[]) + 1
    return i, j
end # function

function work!(world::World, dt)
    world.dogs.member .= work!.(Ref(world), world.dogs.member, dt)
    return nothing
end # function

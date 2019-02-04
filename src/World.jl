using StaticArrays
using GeometryTypes

struct World{F<:Number,D<:Dogs}
    boxsize::Base.RefValue{F}
    dogs::D
end

function World(; v0 = 0, n_dogs = 0, boxsize::F = 0.0, motion::M = BrownianMotion() ) where {F<:Number,M<:Motion}
    dogvec = SizedArray{Tuple{n_dogs},Dog{F}}(undef)
    @inbounds for i in 1:n_dogs
        ϕ = 2π * rand()
        dogvec[i] = Dog(
                        Point2{F}( boxsize .* rand(2) ),
                        Point2{F}( v0 .* [cos(ϕ),sin(ϕ)] ),
                     )
    end # for
    dogs = Dogs{M,n_dogs,Dog{F}}(dogvec, motion)
    return World{F,typeof(dogs)}(Ref(boxsize), dogs)
end # function

function pbc( position::P, world::World ) where P
    p = position
    boxsize = world.boxsize[]
    tx = mod( p[1], boxsize )
    ty = mod( p[2], boxsize )
    while tx < 0; tx += boxsize; end
    while ty < 0; ty += boxsize; end

    return P( tx, ty )
end # function

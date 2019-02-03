struct World{F<:Number,D<:Dogs}
    boxsize::Base.RefValue{F}
    dogs::D
end

function pbc( position::P ) where P
    p = position
    boxsize = world.boxsize[]
    tx = mod( p[1], boxsize )
    ty = mod( p[2], boxsize )
    while tx < 0; tx += boxsize; end
    while ty < 0; ty += boxsize; end

    return P( tx, ty )
end # function

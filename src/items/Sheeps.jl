abstract type Sheeps{L} end

function setNSheep!( sheep::Sheeps, i, j, n )
    oldSheep = _setNSheep!( sheep, i, j, n )
    sheep.current_sheep[] += n - oldSheep
    return nothing
end # function

function kickSheep!( sheep::Sheeps )
    while !isempty(sheep.diffusion_candidates)
        coords = popfirst!( sheep.diffusion_candidates )
        n_sheep = getNSheep( sheep, coords... )
        if n_sheep <= sheep.capacity
            continue
        end # if
        diffuseSheep!( sheep, coords... )
    end # while
end # function

function diffuseSheep!( sheep::Sheeps{L}, i, j ) where L
    #TODO: improve this (more generic, iterators)
    n_sheep = getNSheep( sheep, i, j )
    if n_sheep == 0
        return nothing
    end # if
    setNSheep!( sheep, i, j, n_sheep - 1 )
    r = rand(1:4)
    if r == 1
        i += 1
        if i > L
            i = 1
        end # if
    elseif r == 2
        if i == 1
            i = L
        end # if
        i -= 1
    elseif r == 3
        j += 1
        if j > L
            j = 1
        end # if
    elseif r == 4
        if j == 1
            j = L
        end # if
        j -= 1
    end # if

    new_sheep = getNSheep( sheep, i, j )
    setNSheep!( sheep, i, j, new_sheep + 1 )
    return nothing
end # function

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

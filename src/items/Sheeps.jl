abstract type Sheeps{L} end

function setNSheep!(sheep::Sheeps, i, j, n)
    oldSheep = _setNSheep!(sheep, i, j, n)
    sheep.current_sheep[] += n - oldSheep
    return nothing
end # function

#Diffusion Candidates leeren
function kickSheep!(sheep::Sheeps)
    while !isempty(sheep.diffusion_candidates) #While not empty (! bedeutet not)
        coords = popfirst!(sheep.diffusion_candidates)
        n_sheep = getNSheep(sheep, coords...)
        if n_sheep <= sheep.capacity
            continue
        end # if
        diffuseSheep!(sheep, coords...)
    end # while
end # function

function diffuseSheep!(sheep::Sheeps{L}, i, j) where {L}
    #TODO: improve this (more generic, iterators)
    n_sheep = getNSheep(sheep, i, j)
    if n_sheep == 0
        return nothing
    end # if
    setNSheep!(sheep, i, j, n_sheep - 1)
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

    new_sheep = getNSheep(sheep, i, j)
    setNSheep!(sheep, i, j, new_sheep + 1)
    return nothing
end # function

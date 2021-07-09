"Type for calculating the mean squared displacement."
struct MSD end

function measure(::MSD, sheeps::Sheeps)
    # get center of mass
    cmx, cmy = center_of_mass(sheeps)
    sum = 0
    for sheep in sheeps
        sum += real# sqr distance in real space
    end
    return sum / length(sheeps)
end

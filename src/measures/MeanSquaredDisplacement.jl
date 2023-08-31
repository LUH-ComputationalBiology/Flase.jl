"Type for calculating the mean squared displacement."
struct MSD 
end

function measure(::MSD, sheeps::Sheeps, world::World)
    # get center of mass
    cmx, cmy = center_of_mass(sheeps, world)
    sum = 0
    for sheep in sheeps
        sum += real# sqr distance in real space
    end
    return sum / length(sheeps)
end

function getMSD(msd::MSD, sheeps::Sheeps, word::World, msdNorm::Float64)
    return msd_value
end
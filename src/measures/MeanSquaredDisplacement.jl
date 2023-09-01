"Type for calculating the mean squared displacement."
struct MSD 
end

function measure(::MSD, sheeps::Sheeps, world::World)
    # get center of mass
    gridsizestorage = size(sheeps.grid)[1]
    cmx, cmy = center_of_mass(sheeps, world)
    sum = 0
    for sheep in sheeps
        sum += realSpace_sqr_dist(sheep, gridsizestorage, cmx, cmy, world)  # sqr distance in real space
    end
    return sum / length(sheeps)
end

function getClusterRadius(sheeps::Sheeps, world::World)
    clusterRadius = sqrt(sheeps.current_sheep[] / sheeps.capacity / π) * world.boxsize[] / size(sheeps.grid)[1]
    return clusterRadius
end

function getMSD(msd::MSD, sheeps::Sheeps, world::World)
    R_cl = getClusterRadius(sheeps, world)
    R_item = size(sheeps.grid)[1] / 2
    msdNorm = (R_cl * R_cl) / 2 + R_cl * R_item
    msd_value = msdNorm / measure(msd, sheeps, world)
    println(msdNorm)
    return msd_value
end
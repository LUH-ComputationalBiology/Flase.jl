"Type for calculating the mean squared displacement."
mutable struct MSD 
    vmsd::Int64
end

function measure(vmqd::MSD, sheeps::Sheeps)
    # get center of mass
    cmx, cmy = center_of_mass(sheeps)
    sum = 0
    for sheep in sheeps
        sum += real# sqr distance in real space
    end
    msd.vmsd = sum / length(sheeps)
    return msd.vmsd
end

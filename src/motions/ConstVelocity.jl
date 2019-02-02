using LinearAlgebra
using GeometryTypes

struct ConstVelocity{F<:Number} <: Motion
    noise::F
    persistence_time::F
    persistence_length::F
    effective_diffusion::F
end

function ConstVelocity( noise::F, velocity::F ) where F<:Number
    persistence_time = velocity^2 / noise
    persistence_length = persistence_time * velocity
    effective_diffusion = persistence_length * velocity / 2
    ConstVelocity{F}( noise, persistence_time, persistence_length, effective_diffusion )
end # function

function step( motion::ConstVelocity, positions::P, velocities::V, dt ) where {P,V}
    # Heun algorithm
    vabs = norm( velocities )
    ϕ = atan( velocities[2], velocities[1] )
    old_ϕ = ϕ

    ϕ += sqrt( 2motion.noise * dt ) * randn() / vabs
    new_velocities = vabs * V( cos(ϕ), sin(ϕ) )
    new_positions = positions + dt/2 * P(
        vabs * cos(old_ϕ) + new_velocities[1],
        vabs * sin(old_ϕ) + new_velocities[2],
        )
    return new_positions, new_velocities
end # function

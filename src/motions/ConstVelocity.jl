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

function step( motion::ConstVelocity, position::P, velocity::V, dt ) where {P,V}
    # Heun algorithm
    vabs = norm( velocity )
    ϕ = atan( velocity[2], velocity[1] )
    old_ϕ = ϕ

    ϕ += sqrt( 2motion.noise * dt ) * randn() / vabs
    new_velocity = vabs * V( cos(ϕ), sin(ϕ) )
    new_position = position + dt/2 * P(
        vabs * cos(old_ϕ) + new_velocity[1],
        vabs * sin(old_ϕ) + new_velocity[2],
        )
    return new_position, new_velocity
end # function

struct BrownianMotion{F<:Number} <: Motion
    noise::F
    persistence_time::F
    persistence_length::F
    effective_diffusion::F
    friction::F
end

function BrownianMotion( noise::F, friction::F ) where F<:Number
    persistence_time = 1/friction
    persistence_length = sqrt( noise / friction )
    effectiveDiffusion = noise
    BrownianMotion{F}( noise, persistence_time, persistence_length, effective_diffusion, friction )
end # function

function step( motion::BrownianMotion, position::P, velocity::V, dt ) where {P,V}
    γ = motion.friction
    ξ = motion.noise
    new_velocity = velocity - V(
        γ * velocity[1] * dt - sqrt( 2ξ * γ * dt ) * randn()
        γ * velocity[2] * dt - sqrt( 2ξ * γ * dt ) * randn()
        )
    new_position = position + P(
        new_velocity[1] * dt
        new_velocity[2] * dt·
        )
    return new_position, new_velocity
end # function

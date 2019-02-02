@enum DogState begin
    ACTIVE = 1,
    OCCUPIED,
    SLEEPY
end # enum

Base.@kwdef struct Dog{F<:Number}
    state::DogState = ACTIVE
    sleepyness::UInt32 = 0
    position::Point2{F}
    velocity::Point2{F}
end # struct

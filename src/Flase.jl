module Flase

export InfiniteSimulation, runsim
export BrownianMotion, ConstVelocity
export UnicodePlotter
export World

include("motions/Motion.jl")
include("motions/ConstVelocity.jl")
include("motions/BrownianMotion.jl")

include("collectors/Dog.jl")
include("collectors/Dogs.jl")
# include("items/Sheep.jl")
# include("items/Sheeps.jl")

include("World.jl")

include("plotter/Plotter.jl")
include("plotter/VoidPlotter.jl")
include("plotter/UnicodePlotter.jl")

include("simulations/Simulation.jl")
include("simulations/InfiniteSimulation.jl")

include("interactions.jl")

end # module

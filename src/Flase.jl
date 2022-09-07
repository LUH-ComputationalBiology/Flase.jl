module Flase

export InfiniteSimulation, FiniteSimulation, runsim, ClusterTimeSimulation
export BrownianMotion, ConstVelocity
export UnicodePlotter, VoidPlotter
export World
export DenseSheeps

include("motions/Motion.jl")
include("motions/ConstVelocity.jl")
include("motions/BrownianMotion.jl")

include("collectors/Dog.jl")
include("collectors/Dogs.jl")
include("items/Sheeps.jl")
include("items/BaseSheeps.jl")
include("items/DenseSheeps.jl")
include("items/SparseSheeps.jl")

include("measures/Measure.jl")
include("measures/MeanSquaredDisplacement.jl")
include("measures/MeanQuadraticDistance.jl")

include("World.jl")

include("item-collector-interactions.jl")

include("plotter/Plotter.jl")
include("plotter/VoidPlotter.jl")
include("plotter/UnicodePlotter.jl")

include("simulations/Simulation.jl")
include("simulations/InfiniteSimulation.jl")
include("simulations/FiniteSimulation.jl")
include("simulations/ClusterTimeSimulation.jl")

include("interactions.jl")

end # module

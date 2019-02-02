using Flase, Test

@testset "Dog" begin
    dog = Flase.Dog( [1.,2.], zeros(2) )
    @test typeof(dog) == Flase.Dog{Float64}
    
end # testset

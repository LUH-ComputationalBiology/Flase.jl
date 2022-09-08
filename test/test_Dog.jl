using Flase, Test

@testset "Dog" begin
    dog = Flase.Dog([1.0, 2.0], zeros(2))
    @test typeof(dog) == Flase.Dog{Float64}
    @test Flase.Dog(dog; state = Flase.OCCUPIED).state == Flase.OCCUPIED
end # testset

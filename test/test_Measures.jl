
using Flase
using Test
using StaticArrays
@testset "Mean quadratic distance" begin
    #Test 1
    sheep =
        DenseSheeps(2, Ref(4), Tuple{Int,Int}[], SizedMatrix{3,3}([1 0 2; 0 0 0; 0 0 1]))
    @test Flase.measure(Flase.MQD(), sheep) == 3 / 4

    #Test 2
    sheep1 =
        DenseSheeps(2, Ref(5), Tuple{Int,Int}[], SizedMatrix{3,3}([1 0 2; 0 1 0; 0 0 1]))
    @test Flase.measure(Flase.MQD(), sheep1) == 28 / 25

    #Test 3
    sheep2 =
        DenseSheeps(2, Ref(3), Tuple{Int,Int}[], SizedMatrix{3,3}([1 0 0; 0 1 0; 0 0 1]))
    @test Flase.measure(Flase.MQD(), sheep2) == 12 / 9

end

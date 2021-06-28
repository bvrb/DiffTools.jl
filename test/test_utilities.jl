using DiffTools, StaticArrays
using Test

println("Running " * @__FILE__)

@testset "Vector to complex number" begin
    @test DiffTools.vector_to_complex(SVector{2}(2, 7)) == 2 + 7im
    @test DiffTools.vector_to_complex(SVector{2}(3.4, -1.8)) == 3.4 - 1.8im
end

@testset "Complex number to vector" begin
    @test DiffTools.complex_to_vector(-4 + 3im) == SVector{2}(-4, 3)
    @test DiffTools.complex_to_vector(-0.2 - 20.9im) == SVector{2}(-0.2, -20.9)
end

;
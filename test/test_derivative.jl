using DiffTools: ∂
using Test

@testset "Example derivatives" begin
    @testset begin 
        f(z) = 3z*z - 4z + 10 
        @test ∂(f, 2) == 8
        @test ∂(f, 2 + 0im) == 8 + 0im
        @test ∂(f, 1 - 2im) == 2 - 12im
    end

    @testset begin
        f(z) = 2z*z*z - z + im * (12z + 4)
        @test ∂(f, 2 + 0im) == 23 + 12im
        @test ∂(f, im) == -7 + 12im
        @test ∂(f, -1 - im) == -1 + 24im
    end

    @testset begin 
        f(z) = exp(3*z) 
        @test ∂(f, 0 + 0im) == 3 + 0im
        @test ∂(f, 1 + 0im) == 3ℯ^3 + 0im 
        @test ∂(f, -1 + im) == 3ℯ^(-3) * cis(3)
    end
end
;
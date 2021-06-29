using DiffTools: DiffTools, ∂, ∂²
using Test

println("Running " * @__FILE__)

@testset "Example derivatives" begin
    @testset "Function 1" begin 
        f(z) = 3z*z - 4z + 10 

        @test ∂(f, 2) == 8
        @test ∂²(f, 2) == 6

        @test ∂(f, 2 + 0im) == 8 + 0im
        @test ∂²(f, 2 + 0im) == 6 + 0im

        @test ∂(f, 1 - 2im) == 2 - 12im
        @test ∂²(f, 1 - 2im) == 6 + 0im
    end

    @testset "Function 2" begin
        f(z) = 2z*z*z - z + im * (12z + 4)

        @test ∂(f, 2 + 0im) == 23 + 12im
        @test ∂²(f, 2 + 0im) == 24 + 0im

        @test ∂(f, im) == -7 + 12im
        @test ∂²(f, im) == 12im

        @test ∂(f, -1 - im) == -1 + 24im
        @test ∂²(f, -1 - im) == -12 - 12im
    end

    @testset "Function 3" begin 
        f(z) = exp(3*z) 

        @test ∂(f, 0 + 0im) == 3 + 0im
        @test ∂²(f, 0 + 0im) == 9 + 0im

        @test ∂(f, 1 + 0im) == 3ℯ^3 + 0im 
        @test ∂²(f, 1 + 0im) == 9ℯ^3 + 0im 

        @test ∂(f, -1 + im) == 3ℯ^(-3) * cis(3)
        @test ∂²(f, -1 + im) ≈ 9ℯ^(-3) * cis(3)
    end
end

@testset "Precision loss regression tests" begin
    f(z) = sincos(z)[1]
    @test ∂(f, 1) == cos(1)
    @test ∂(f, 1 + 0im) == cos(1) + 0.0im
    @test ∂²(f, 1) == -sin(1)
    @test ∂²(f, 1 + 0im) == -sin(1) + 0.0im
end

@testset "Cauchy-Riemann" begin
# Since we are calculating all four partial derivatives for 
# ``f(x + iy) = u(x,y) + iv(x,y)`` anyway, check that the 
# Cauchy-Riemann equations are fulfilled
    @testset "Function 1" begin 
        f(z) = 3z*z - 4z + 10 
        a = DiffTools.complex_to_vector(2 - 3im)
        fvec(a) = DiffTools.fvector(f, a)
        jacobian = DiffTools.intermediate_jacobian(fvec, a)
        ∂u∂x, ∂v∂x, ∂u∂y, ∂v∂y = jacobian
        @test ∂u∂x == ∂v∂y
        @test ∂u∂y == -∂v∂x
    end

    @testset "Function 2" begin 
        f(z) = exp(3*z)
        a = DiffTools.complex_to_vector(-4 - 5im)
        fvec(a) = DiffTools.fvector(f, a)
        jacobian = DiffTools.intermediate_jacobian(fvec, a)
        ∂u∂x, ∂v∂x, ∂u∂y, ∂v∂y = jacobian
        @test ∂u∂x == ∂v∂y
        @test ∂u∂y ≈ -∂v∂x
    end
end

;

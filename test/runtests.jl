using DiffTools: ∂
using Test

f(x) = 3x^2 - 4x + 10 
@test ∂(f, 2) == 8

f(z) = 2z*z*z - z + im * (12z + 4)
@test ∂(f, 2 + 0im) == 23 + 12im
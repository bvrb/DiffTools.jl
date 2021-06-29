# Wrappers to the ForwardDiff (https://github.com/JuliaDiff/ForwardDiff.jl) package in 
# order to allow for derivatives of complex functions

"""
    [∂|derivative](f, x)

Directly call `ForwardDiff.derivative(f, x)`.
"""
∂(f, x) = ForwardDiff.derivative(f, x)

"""
    function [∂|derivative](f, z::Complex)

Calculate the derivative of a holomorphic complex-valued function `f` with complex 
argument `z` via automatic differentiation using ForwardDiff.
"""
function ∂(f, z::Complex)
    result = first_jacobian_column(a -> fvector(f, a), complex_to_vector(z))
    return vector_to_complex(result)
end

# Create more verbose alias
const derivative = ∂

"""
    [∂²|second_derivative](f, x)

Directly call `ForwardDiff.derivative(f, x)`, twice.
"""
∂²(f, x) = ForwardDiff.derivative(x -> ForwardDiff.derivative(f, x), x)

"""
    function [∂²|second_derivative](f, z::Complex)

Calculate the second derivative of a holomorphic complex-valued function `f` 
with complex argument `z` via automatic differentiation using ForwardDiff.
"""
function ∂²(f, z::Complex)
    result = first_jacobian_column(a -> first_jacobian_column(a -> fvector(f, a), a), complex_to_vector(z))
    return vector_to_complex(result)
end

# Create more verbose alias
const second_derivative = ∂²

# The following methods are a workaround for unexpected loss of precision in some cases when using Integer literals as arguments
# (c.p. https://github.com/JuliaDiff/ForwardDiff.jl/issues/362 , https://github.com/JuliaDiff/ForwardDiff.jl/issues/492 , https://github.com/JuliaDiff/ForwardDiff.jl/pull/419 ,
# underlying cause: https://github.com/JuliaDiff/ForwardDiff.jl/blob/909976d719fdbd5fec91a159c6e2d808c45a770f/src/dual.jl#L374 )
# and can be deleted once the respective PR has been merged 

function ∂(f, x::Int)
    x = convert(Float64, x)
    ∂(f, x)
end

function ∂(f, z::Complex{Int})
    z = convert(ComplexF64, z)
    ∂(f, z)
end

function ∂²(f, x::Int)
    x = convert(Float64, x)
    ∂²(f, x)
end

function ∂²(f, z::Complex{Int})
    z = convert(ComplexF64, z)
    ∂²(f, z)
end

# End of workaround


"""
    intermediate_jacobian(f, a::SVector{2})

Calculate the Jacobian matrix for the vector function `f` describing the 
transformation ``\vec{f}(x,y) = (u(x,y), v(x,y))ᵀ`` at a given point 
``\vec{a} = (x₀,y₀)ᵀ`` via ForwardDiff.
"""
function intermediate_jacobian(f, a::SVector{2})
    result = ForwardDiff.jacobian(f, a)
    return SMatrix{2,2}(result)
end

"""
    function fvector(f, a::SVector{2})

Convert complex-valued function `f` with complex argument `z` -- where ``f(z) = u + iv`` -- 
to vector-valued function ``\vec{f}(x,y) = (u(x,y), v(x,y))ᵀ`` with vector argument `a`.
"""
function fvector(f, a::SVector{2})
    return complex_to_vector(f(vector_to_complex(a)))
end

"Return first column of the intermediately calculated Jacobian for vector function `f` at `a`."
function first_jacobian_column(f, a::SVector{2})
    return first_column(intermediate_jacobian(f, a))
end

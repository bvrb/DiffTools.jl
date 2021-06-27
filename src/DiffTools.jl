module DiffTools

using ForwardDiff, StaticArrays

∂(f, x) = ForwardDiff.derivative(f, x)


function vector_to_complex(a::SVector{2}) #TODO type, number of dimensions
    return complex(a[1], a[2])
end

function complex_to_vector(z::Complex) #TODO type, number of dimensions
    return SVector{2}(real(z), imag(z))
end

function intermediate_jacobian(f, z::Complex)
    result = ForwardDiff.jacobian(x -> complex_to_vector(f(vector_to_complex(SVector{2}(x)))), complex_to_vector(z))
    return SMatrix{2,2}(result)
end

"""
    function ∂(f, z::Complex)

Calculates the derivative of a holomorphic complex-valued function `f` with complex argument `z` via automatic differentiation using ForwardDiff.
"""
function ∂(f, z::Complex)
    index = @SVector [1,2]
    result = intermediate_jacobian(f, z)[index]
    return vector_to_complex(result)
end

end # module

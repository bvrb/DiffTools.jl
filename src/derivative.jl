
∂(f, x) = ForwardDiff.derivative(f, x)


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

function ∂(f, z::Complex{Int})
# This method is a workaround for unexpected loss of precision in some cases when using Integer literals
# (c.p. https://github.com/JuliaDiff/ForwardDiff.jl/issues/362 , https://github.com/JuliaDiff/ForwardDiff.jl/issues/492 , https://github.com/JuliaDiff/ForwardDiff.jl/pull/419 ,
# underlying cause: https://github.com/JuliaDiff/ForwardDiff.jl/blob/909976d719fdbd5fec91a159c6e2d808c45a770f/src/dual.jl#L374 )
# and can be deleted once the respective PR has been merged 
    z = convert(ComplexF64, z)
    ∂(f, z)
end
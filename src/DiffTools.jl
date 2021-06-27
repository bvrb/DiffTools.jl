module DiffTools

#using ForwardDiff, StaticArrays
using ForwardDiff: ForwardDiff, Dual
using StaticArrays 

# Modified from https://github.com/JuliaDiff/ForwardDiff.jl/blob/909976d719fdbd5fec91a159c6e2d808c45a770f/src/dual.jl#L374 
# in order to work around https://github.com/JuliaDiff/ForwardDiff.jl/issues/362 , https://github.com/JuliaDiff/ForwardDiff.jl/issues/492 , https://github.com/JuliaDiff/ForwardDiff.jl/pull/419
# which will otherwise lead to loss of precision in some cases when using Integer literals
Base.float(d::Dual{T,V,N}) where {T,V,N} = convert(Dual{T,promote_type(V, Float64),N}, d)
Base.AbstractFloat(d::Dual{T,V,N}) where {T,V,N} = convert(Dual{T,promote_type(V, Float64),N}, d)

∂(f, x) = ForwardDiff.derivative(f, x)


function vector_to_complex(a::SVector{2})
    return complex(a[1], a[2])
end

function complex_to_vector(z::Complex)
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

# Utility functions needed in other routines

"Convert SVector of length 2 to complex number."
function vector_to_complex(a::SVector{2})
    return complex(a[1], a[2])
end

"Convert complex number to SVector of length 2."
function complex_to_vector(z::Complex)
    return SVector{2}(real(z), imag(z))
end

"""
    first_column(A::SMatrix{2,2})

Extract first column of a 2x2 SMatrix.
"""
function first_column(A::SMatrix{2,2})
    index = SVector{2}(1,2)
    return A[index]
end

# Utility functions needed in other routines

"Convert SVector of length 2 to complex number."
function vector_to_complex(a::SVector{2})
    return complex(a[1], a[2])
end

"Convert complex number to SVector of length 2."
function complex_to_vector(z::Complex)
    return SVector{2}(real(z), imag(z))
end

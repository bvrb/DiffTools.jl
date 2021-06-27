
function vector_to_complex(a::SVector{2})
    return complex(a[1], a[2])
end

function complex_to_vector(z::Complex)
    return SVector{2}(real(z), imag(z))
end

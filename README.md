# DiffTools.jl
A collection of convenience wrappers for using automatic differentiation (via [ForwardDiff](https://github.com/JuliaDiff/ForwardDiff.jl)) in Julia, which have occasionally been useful in my projects.

## Complex derivative

To calculate the complex derivative of a (holomorphic) function `f`, we can do

```julia
julia> using DiffTools: ∂

julia> f(z) = exp(2z)
f (generic function with 1 method)

julia> ∂(f, 1 + 1im)
-6.149864641278718 + 13.4376993948565im

julia> 2 * ℯ^2 * cis(2)
-6.149864641278718 + 13.4376993948565im
```

or

```julia
julia> using DiffTools

julia> f(z) = z*z - z
f (generic function with 1 method)

julia> DiffTools.derivative(f, 2 - 2im)
3.0 - 4.0im

julia> 2 * (2 - 2im) - 1
3 - 4im
```

(Using `z*z` instead of `z^2`, see [#514](https://github.com/JuliaDiff/ForwardDiff.jl/issues/514)).

For real-world applications, compare [Zygote](https://fluxml.ai/Zygote.jl/latest/complex/) or [ChainRules](https://juliadiff.org/ChainRulesCore.jl/dev/complex.html). 


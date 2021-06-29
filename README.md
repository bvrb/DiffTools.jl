# DiffTools.jl
A collection of convenience wrappers for using automatic differentiation (via [ForwardDiff](https://github.com/JuliaDiff/ForwardDiff.jl)) in Julia, which have occasionally been useful in my projects.

## Complex derivative

To calculate the complex derivative of a (holomorphic) function `f`, we can do

```julia
julia> using DiffTools: ∂, ∂²

julia> f(z) = exp(2z) + sin(z)
f (generic function with 1 method)

julia> ∂(f, 1 + 1im)
-5.316134616147569 + 12.448801689093635im

julia> 2 * ℯ^2 * cis(2) + cos(1 + 1im)
-5.316134616147569 + 12.448801689093635im

julia> ∂²(f, 1 + 1im)
-13.598186863973414 + 26.240434874928262im

julia> 4 * ℯ^2 * cis(2) - sin(1 + 1im)
-13.598186863973414 + 26.240434874928262im

```

or

```julia
julia> using DiffTools

julia> f(z) = z*z*z - z*z
f (generic function with 1 method)

julia> DiffTools.derivative(f, 2 - 2im)
-4.0 - 20.0im

julia> 3 * (2 - 2im)^2 - 2 * (2 - 2im)
-4 - 20im

julia> DiffTools.second_derivative(f, 2 - 2im)
10.0 - 12.0im

julia> 6 * (2 - 2im) - 2
10 - 12im
```

(Using `z*z` instead of `z^2`, see [#514](https://github.com/JuliaDiff/ForwardDiff.jl/issues/514)).

For real-world applications, the methods in this package in all likelihood do not constitute the optimal approach to tackle such problems.
Have a look at e.g. [Zygote](https://fluxml.ai/Zygote.jl/latest/complex/) or [ChainRules](https://juliadiff.org/ChainRulesCore.jl/dev/complex.html).

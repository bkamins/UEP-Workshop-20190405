using LinearAlgebra
using Random
using ForwardDiff
using DataFrames
using GLM

function marquardt(f, x₀; ε=1e-6, maxiter=1000, λ=10.0^4, α=2)
    x = x₀
    fx = f(x)
    converged = false
    i = 0
    while i < maxiter
        i += 1
        ∇f = ForwardDiff.gradient(f, x)
        if norm(∇f) ≤ ε
            converged = true
            break
        end
        ∇²f = ForwardDiff.hessian(f, x)
        x′ = x - (∇²f + λ*I) \ ∇f
        fx′ = f(x′)
        if fx′ < fx
            λ *= 0.5
            fx = fx′
            x = x′
        else
            λ *= 2.0
        end
    end
    (x=x, fx=fx, converged=converged, iters=i)
end

rosenbrock(x) = sum((1-x[i])^2 + 100(x[i+1]-x[i]^2)^2 for i in 1:length(x)-1)

Random.seed!(1234)
x = rand(20);
marquardt(rosenbrock, x)

Random.seed!(123)
N = 1000
df = DataFrame(rand(N, 4))
df.y = sum.(eachrow(df)) + randn(N);
lm(@formula(y~x1+x2+x3+x4), df)

# This is not very efficient, but is good enough in our case
function ssq(x)
    m = Matrix(df)[:, startswith.(string.(names(df)), "x")]
    norm(df.y - fill(x[1], nrow(df)) - m * x[2:end])
end
marquardt(ssq, rand(5))

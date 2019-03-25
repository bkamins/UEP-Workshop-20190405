# Bogumił Kamiński, 2019-03-25

using Statistics, Distributions

function v_asian_sample1(T, r, K, σ, X₀, m)
    X = X₀
    hatx = zero(X)
    Δ = T / m
    for i in 1:m
        X *= exp((r-σ^2/2)*Δ + σ*√Δ*randn())
        hatx += X
    end
    exp(-r*T)*max(hatx/m - K, 0)
end

function v_asian_sample2(T, r, K, σ, X₀, m)
    Δ = T / m
    X = rand(Normal((r-σ^2/2)*Δ, σ*√Δ), m)
    exp(-r*T)*max(mean(exp.(cumsum(X))) * X₀ - K, 0)
end

function v_asian(T, r, K, σ, X₀, m, n, sampler)
    mean(sampler(T, r, K, σ, X₀, m) for i in 1:n)
end

for f in [v_asian_sample1, v_asian_sample2]
    @time println(v_asian(1.0, 0.05, 55.0, 0.3, 50.0, 10_000, 10_000, f))
end

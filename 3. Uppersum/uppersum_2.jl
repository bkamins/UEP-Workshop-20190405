# Bogumił Kamiński, 2019-03-25

function uppersum(M::AbstractMatrix{T}) where {T<:Number}
    n = size(M, 1)
    @assert size(M, 1) == size(M, 1)
    s = zero(T)
    for i in 2:n
        @simd for j in 1:i
            @inbounds s += M[j, i]
        end
    end
    s
end

@time m = randn(10_000, 10_000);
@time m = randn(10_000, 10_000);

m

@time sum(m)
@time sum(m)

@time uppersum(M)
@time uppersum(M)

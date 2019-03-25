# Bogumił Kamiński, 2019-03-25

function uppersum(M)
    n = size(M, 1)
    s = 0
    for i in 2:n, j in 1:i
        s += M[j, i]
    end
    s
end

@time m = randn(10_000, 10_000);
@time m = randn(10_000, 10_000);

m

@time sum(m)
@time sum(m)

@time sum(UpperTriangular(m))
@time sum(UpperTriangular(m))

@time uppersum(M)
@time uppersum(M)

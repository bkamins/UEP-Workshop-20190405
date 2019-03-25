# Bogumił Kamiński, 2019-03-25

function sieve(n)
    isprime = trues(n)
    isprime[1] = false
    for i in 2:isqrt(n)
        if isprime[i]
            for j in i^2:i:n
                isprime[j] = false
            end
        end
    end
    return filter(i -> isprime[i], 1:n)
end

sieve(100)
@time length(sieve(10^6))

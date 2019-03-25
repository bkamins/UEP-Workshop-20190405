# Bogumił Kamiński, 2019-03-25

system.time(m <- matrix(rnorm(10000^2), ncol=10000))

m

system.time(m[lower.tri(m)] <- 0)
system.time(sum(m))

# Bogumił Kamiński, 2019-03-25

using DelimitedFiles, Random

Random.seed!(1234)
x = rand(10, 10)

open("x.txt", "w") do f
    writedlm(f, x)
end

x2 = readdlm("x.txt")

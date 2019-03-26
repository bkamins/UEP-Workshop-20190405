# Bogumił Kamiński, 2019-03-25

using Serialization

d = Dict{Int, String}()

for i in 1:10
    d[i] = string(i)
end

if VERSION >= v"1.1"
    serialize("d.bin", d)
    d2 = deserialize("d.bin")
else
    with("d.bin", "w") do f
        serialize(f, d)
    end
    f = open("d.bin")
    d2 =deserialize("d.bin")
    close(f)
end

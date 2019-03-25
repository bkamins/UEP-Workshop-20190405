# Bogumił Kamiński, 2019-03-25

const TRAIN = (class=UInt8[], image=Matrix{Int32}[])
const TEST = (class=UInt8[], image=Matrix{Int32}[])

for (filename, data) in [("mnist_train.int", TRAIN),
                         ("mnist_test.int", TEST)]
    open(filename) do f
        while !eof(f)
            c = read(f, UInt8)
            v = read(f, 28^2)
            push!(data.class, c)
            push!(data.image, reshape(v, 28, 28))
        end
    end
end

nonzero = sum(sum(img[1:3, :] .!= 0) +
              sum(img[:, 1:3] .!= 0) +
              sum(img[end-3:end, :] .!= 0) +
              sum(img[:, end-3:end] .!= 0)
              for img in Iterators.flatten([TRAIN.image, TEST.image]))
nonzero / (28^2 * (length(TRAIN.image) + length(TRAIN.image)))

# Bogumił Kamiński, 2019-03-25

# Reworked example from
# https://github.com/FluxML/model-zoo/blob/master/vision/mnist/mlp.jl

using Statistics
using Flux

const TRAIN = (class=UInt8[], image=Vector{Float64}[])
const TEST = (class=UInt8[], image=Vector{Float64}[])

for (filename, data) in [("mnist_train.int", TRAIN),
                         ("mnist_test.int", TEST)]
    open(filename) do f
        while !eof(f)
            c = read(f, UInt8)
            v = read(f, 28^2)
            push!(data.class, c)
            push!(data.image, v ./ 255)
        end
    end
end

const DELETE = findall([std(img[i] for img in TRAIN.image) < 0.04 for i in 1:28^2])

deleteat!.(TRAIN.image, Ref(DELETE))
deleteat!.(TEST.image, Ref(DELETE))

Y = Flux.onehotbatch(TRAIN.class, 0:9);
X = reduce(hcat, TRAIN.image);

m = Chain(Dense(28^2-length(DELETE), 64, relu),
          Dense(64, 64, relu),
          Dense(64, 64, relu),
          Dense(64, 10),
          softmax)

loss(x, y) = Flux.crossentropy(m(x), y)
accuracy(x, y) = mean(Flux.onecold(m(x)) .== Flux.onecold(y))
dataset = Iterators.repeated((X, Y), 200)
evalcb = () -> @show(loss(X, Y))
opt = ADAM()

Flux.train!(loss, params(m), dataset, opt, cb = Flux.throttle(evalcb, 10))
accuracy(X, Y)

tY = Flux.onehotbatch(TEST.class, 0:9);
tX = reduce(hcat, TEST.image);
accuracy(tX, tY)

using Flux, Flux.Data.MNIST, Statistics, BSON, Random, StatsPlots; pyplot()
using Flux: onehotbatch, onecold, crossentropy, @epochs

epochs = 30
eta = 1e-3
batchSize = 200
trainRange, validateRange = 1:1000, 1001:5000

function minibatch(x, y, idxs)
    xBatch = Array{Float32}(undef, size(x[1])..., 1, length(idxs))
    for i in 1:length(idxs)
        xBatch[:, :, :, i] = Float32.(x[idxs[i]])
    end
    return (xBatch, onehotbatch(y[idxs], 0:9))
end

trainLabels = MNIST.labels()[trainRange]
trainImgs = MNIST.images()[trainRange]
mbIdxs = Iterators.partition(1:length(trainImgs), batchSize)
trainSet = [minibatch(trainImgs, trainLabels, i) for i in mbIdxs]

validateLabels = MNIST.labels()[validateRange]
validateImgs = MNIST.images()[validateRange]
validateSet = minibatch(validateImgs, validateLabels, 1:length(validateImgs))

accuracy(x, y, model) = mean(onecold(model(x)) .== onecold(y))
loss(x, y, model) = crossentropy(model(x), y)

function evalAccuracy(dropP)
    model= Chain(Conv((5, 5), 1=>8, relu), MaxPool((2,2)),
                    Conv((3, 3), 8=>16, relu), MaxPool((2,2)),
                    flatten,
                    Dense(400, 200,relu), Dropout(dropP),
                    Dense(200, 200,relu), Dropout(dropP),
                    Dense(200, 200,relu), Dropout(dropP),
                    Dense(200, 10,relu), Dropout(dropP),
                    softmax)
    opt = ADAM(eta);
    @epochs epochs Flux.train!((x,y)->loss(x,y,model),params(model),trainSet,opt)
    accuracy(validateSet..., model)
end

pToTest = [0.0, 0.25, 0.5, 0.75]
n = 10
results = [[evalAccuracy(p) for _ in 1:n] for p in pToTest]
bestAcc, bestI = findmax(median.(results))
println("The best dropout probability is $(pToTest[bestI]).")
println("It achieves $(bestAcc) accuracy on average.")

boxplot(results,label="",
       xticks=([1:1:4;],string.(pToTest)),
       xlabel="Dropout Probability", ylabel = "Accuracy", legend = false)

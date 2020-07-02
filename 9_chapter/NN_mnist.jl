using Flux, Flux.Data.MNIST, Statistics, BSON, Random, Plots; pyplot()
using Flux: onehotbatch, onecold, crossentropy
Random.seed!(0)

epochs = 30
eta = 5e-3
batchSize = 1000
trainRange, validateRange = 1:5000, 5001:10000

function minibatch(x, y, indexRange)
    xBatch = Array{Float32}(undef, size(x[1])..., 1, length(indexRange))
    for i in 1:length(indexRange)
        xBatch[:, :, :, i] = Float32.(x[indexRange[i]])
    end
    return (xBatch, onehotbatch(y[indexRange], 0:9))
end

trainLabels = MNIST.labels()[trainRange]
trainImgs = MNIST.images()[trainRange]
mbIdxs = Iterators.partition(1:length(trainImgs), batchSize)
trainSet = [minibatch(trainImgs, trainLabels, bi) for bi in mbIdxs]

validateLabels = MNIST.labels()[validateRange]
validateImgs = MNIST.images()[validateRange]
validateSet = minibatch(validateImgs, validateLabels, 1:length(validateImgs))

model1= Chain(flatten, Dense(784, 200,relu),Dense(200, 100,tanh),
				Dense(100, 10,sigmoid), softmax)

model2= Chain(Conv((5, 5), 1=>8, relu), MaxPool((2,2)),
                Conv((3, 3), 8=>16, relu), MaxPool((2,2)),
                flatten, Dense(400, 10), softmax)

opt1 = ADAM(eta); opt2 = ADAM(eta)
accuracyPaths = [[],[]]
accuracy(x, y, model) = mean(onecold(model(x)) .== onecold(y))
loss(x, y, model) = crossentropy(model(x), y)
cbF1() = push!(accuracyPaths[1],accuracy(validateSet..., model1))
cbF2() = push!(accuracyPaths[2],accuracy(validateSet..., model2))

model1(trainSet[1][1]); model2(trainSet[1][1])
for _ in 1:epochs
    Flux.train!((x,y)->loss(x,y,model1), params(model1), trainSet, opt1, cb=cbF1)
    Flux.train!((x,y)->loss(x,y,model2), params(model2), trainSet, opt2, cb=cbF2)
	print(".")
end

println("\nModel1 (Dense) accuracy = ", accuracy(validateSet..., model1))
println("Model2 (Convolutional) accuracy = ", accuracy(validateSet..., model2))
cd(@__DIR__)
BSON.@save "../data/mnistConv.bson" modelParams=cpu.(params(model2))
plot(accuracyPaths,label = ["Dense" "Convolutional"],
	ylim=(0.7,1.0), xlabel="Batch number", ylabel = "Validation Accuracy")

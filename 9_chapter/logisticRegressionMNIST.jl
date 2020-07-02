using Flux, Flux.Data.MNIST, Statistics, BSON, Random, StatsBase, Plots; pyplot()
using Flux: params, onehotbatch, crossentropy, update!
Random.seed!(0)

nTrain = 20000
miniBatchSize = 1000
imgs   = Flux.Data.MNIST.images()[1:nTrain]
labels = Flux.Data.MNIST.labels()[1:nTrain]

trainData = hcat([vcat(float.(imgs[i])...) for i in 1:nTrain]...)
trainLabels = labels

testImgs = Flux.Data.MNIST.images(:test)
testLabels = Flux.Data.MNIST.labels(:test)
nTest = length(testImgs)
testData = hcat([vcat(float.(testImgs[i])...) for i in 1:nTest]...)

W = randn(10,28*28)
b = randn(10)

logisticM(imgVec) = softmax(W*imgVec .+ b)
logisticMclassifier(imgVec) = argmax(logisticM(imgVec))-1
loss(x,y) = crossentropy(logisticM(x),onehotbatch(y,0:9))
opt = ADAM(0.01)

lossValue = 0.0
lossArray = []
epochNum = 0
while true
    global lossValue
    prevLossValue = lossValue
    for batch in Iterators.partition(1:nTrain,miniBatchSize)
      gs = gradient(()->loss(trainData[:,batch],trainLabels[batch]),params(W,b))
      for p in (W,b)
          update!(opt,p,gs[p])
      end
    end
    global epochNum += 1
    lossValue = loss(trainData,trainLabels)
    push!(lossArray,lossValue)
    print(".")
    abs(prevLossValue-lossValue) < 5e-4 && break
end

println("\nNumber of epochs: ", epochNum)
acccuracy = mean([logisticMclassifier(testData[:,k]) for k in 1:nTest]
                .== testLabels)
println("Accuracy: ", acccuracy)

plot(lossArray, xlabel = "Epoch", ylabel = "Cross Entropy Loss", legend = false)

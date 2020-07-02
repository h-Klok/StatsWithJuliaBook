using Flux, Flux.Data.MNIST, Statistics, BSON, StatsBase, Plots; pyplot()
using Flux: onecold

model= Chain(Conv((5, 5), 1=>8, relu), MaxPool((2,2)),
             Conv((3, 3), 8=>16, relu), MaxPool((2,2)),
                flatten, Dense(400, 10), softmax)

BSON.@load "../data/mnistConv.bson" modelParams
Flux.loadparams!(model, modelParams)

function predictor(img)
    whcn = ones(Float32,28,28, 1, 1)
    whcn[:,:,1,1] = Float32.(img)
    onecold(model(whcn),0:9)[1]
end

testLabels = Flux.Data.MNIST.labels(:test)
testImages = Flux.Data.MNIST.images(:test)
nTest = length(testLabels)

iC, iR = 0, 0
nCorrect = 0
goodExamples = zeros(Int,10)
badExamples = zeros(Int,10)
predictedBad = zeros(Int,10)
for i in 1:nTest
    prediction = predictor(testImages[i])
    trueLabel = testLabels[i]
    predictionIsCorrect = (prediction == trueLabel)
    global nCorrect += predictionIsCorrect
    global iC; global iR
    if predictionIsCorrect && trueLabel == iC
        goodExamples[iC+1] = i
        iC += 1
    end
    if !predictionIsCorrect && trueLabel == iR
        badExamples[iR+1] = i
        predictedBad[iR+1] = prediction
        iR += 1
    end
end

println("Percentage correctly classified: ", 100*nCorrect/nTest)

default(yflip = true, size = (1000,300),
        legend=false,color = :Greys,ticks=false)
p1 = heatmap(hcat(float.(testImages[goodExamples])...))
p2 = heatmap(hcat(float.(testImages[badExamples])...))
for i in 1:10
    annotate!(28i-3,25,text("$(predictedBad[i])",18))
end
plot(p1,p2,layout=(2,1))
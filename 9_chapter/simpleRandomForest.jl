using Flux.Data.MNIST, DecisionTree, Random
Random.seed!(0)

trainImgs   = MNIST.images()
trainLabels = MNIST.labels()
nTrain = length(trainImgs)
trainData = vcat([hcat(float.(trainImgs[i])...) for i in 1:nTrain]...)

testImgs = MNIST.images(:test)
testLabels = MNIST.labels(:test)
nTest = length(testImgs)
testData = vcat([hcat(float.(testImgs[i])...) for i in 1:nTest]...)

numFeaturesPerTree = 10
numTrees = 40
portionSamplesPerTree = 0.7
maxTreeDepth = 10

model = build_forest(trainLabels, trainData, 
                    numFeaturesPerTree, numTrees, 
                    portionSamplesPerTree, maxTreeDepth)
println("Trained model:")
println(model)

predicted_labels = [apply_forest(model, testData[k,:]) for k in 1:nTest]
accuracy = sum(predicted_labels .== testLabels)/nTest
println("\nPrediction accuracy (measured on test set of size $nTest): ",accuracy)
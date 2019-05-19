using Flux.Data.MNIST, DecisionTree, PyPlot, Random
Random.seed!(1)

imgs   = MNIST.images()
labels = MNIST.labels()

trainData = vcat([hcat(float.(imgs[i])...) for i in 1:50000]...)
trainLabels = labels[1:50000]

testData = vcat([hcat(float.(imgs[i])...) for i in 50001:60000]...)
testLabels = labels[50001:60000]

model = build_forest(trainLabels, trainData, 10, 40, 0.7, 10)

predicted_labels = [apply_forest(model, testData[k,:]) for k in 1:10000]

accuracy = sum(predicted_labels .== testLabels)/10000
println("Prediction accuracy (measured on test set of size 100): ", accuracy)

k = 1
while predicted_labels[k] == testLabels[k]
    global k +=1
end
println("Example error (MNIST image $(50000+k)):",
        " Predicted $(predicted_labels[k]) but it is actually $(testLabels[k]).")

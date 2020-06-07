using Flux.Data.MNIST, LIBSVM, Plots

imgs   = MNIST.images()
labels = MNIST.labels()

trainData = hcat([vcat(float.(imgs[i])...) for i in 1:1000]...)
trainLabels = labels[1:1000]

testData = hcat([vcat(float.(imgs[i])...) for i in 1001:2000]...)
testLabels = labels[1001:2000]

model = svmtrain(trainData,trainLabels)

(predicted_labels, decision_values) = svmpredict(model, testData)

accuracy = sum(predicted_labels .== testLabels)/1000
println("Prediction accuracy (measured on test set of size 1000): ", accuracy)

showImages = float.(imgs[1001:1010])
matshow(hcat(showImages...), cmap="Greys")
for i in 1:10
    ok = predicted_labels[i] == testLabels[i] ? "" : "x"
    annotate("$(predicted_labels[i])$(ok)", xy=(28i-10,25), xytext=(28i-10, 25),
    		bbox=Dict("fc"=>"0.8"))
end

QQQQ breaking
p1 = heatmap(showImages[1])
p2 = heatmap(showImages[2])
p3 = heatmap(showImages[3])
p4 = heatmap(showImages[4])

plot(p1, p2, p3, p4, layout=(1,4), color=:Greys)

default(color=:Greys, colorbar_entry=false, ratio=:equal, xaxis=false, yaxis=false)
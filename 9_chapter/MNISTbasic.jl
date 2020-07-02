using MLDatasets, StatsBase, Measures, Plots; pyplot()

xTrain, yTrain = MLDatasets.MNIST.traindata(Float32)
xTest, yTest = MLDatasets.MNIST.testdata(Float32)
nTrain, nTest = size(xTrain)[3], size(xTest)[3]
trainData = [xTrain[:,:,k]' for k in 1:nTrain]
testData = [xTest[:,:,k]' for k in 1:nTest]
positiveTrain = trainData[yTrain .== 1]
negativeTrain = trainData[yTrain .!= 1]
testLabels = yTest .== 1

function peakProp(img)
	peakSum = 0.0
	for j in 1:28
		m = argmax(img[j,:])
		(m <=2 || m >= 26) && continue
		peakSum += sum(img[j,m-2:m+2])
	end
	peakSum/sum(img)
end
predict(img,theta) = peakProp(img) <= theta ? false : true
function F1value(theta)
	predictionOnPositive = predict.(positiveTrain,theta)
	predictionOnNegative = predict.(negativeTrain,theta)
	TP = sum(predictionOnPositive)
	FN = sum(1 .- predictionOnPositive)
	FP = sum(predictionOnNegative)
	TN = sum(1 .- predictionOnNegative)
	recall, precision = TP/(TP + FN), TP/(TP + FP)
	return 2*(precision*recall)/(precision+recall)
end

psPositive, psNegative = peakProp.(positiveTrain), peakProp.(negativeTrain)
thetaRange = 0.5:0.005:1
f1Values = F1value.(thetaRange)

bestF1, bestIndex = findmax(f1Values)
bestTheta = thetaRange[bestIndex]
println("Best theta = ", bestTheta, " with F1 value of ", bestF1)

println("On test set:")
testPredictions = predict.(testData,bestTheta)
TP, FN = sum(testPredictions[testLabels]), sum(.!testPredictions[testLabels])
FP, TN = sum(testPredictions[.!testLabels]), sum(.!testPredictions[.!testLabels])
recall, precision = TP/(TP + FN), TP/(TP + FP)
F1test = harmmean([precision,recall])
@show TP, FN, FP, TN; @show recall, precision; @show F1test

p1 = stephist(psPositive, normed = true, label="1 Digit",bins=50)
stephist!(psNegative, normed = true, xlim=(0.4,1), ylim=(0,6),bins=50,
			xlabel = "Value", ylabel = "Frequency",
			label="Non 1 Digit")
plot!([bestTheta,bestTheta],[0,5], c =:black, label = :none)
p2 = plot(thetaRange,f1Values, legend = false,
	xlabel = "Threshold", ylabel = "F1 Value")
plot!([bestTheta],[bestF1], c=:black)
plot(p1,p2,size=(800,400))
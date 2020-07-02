using Flux.Data.MNIST, LIBSVM, Plots

logFilePath = "../data/svmlog.txt"
nTrain = 10^4

trainImgs   = MNIST.images()[1:nTrain]
trainLabels = MNIST.labels()[1:nTrain]
trainData = hcat([vcat(float.(trainImgs[i])...) for i in 1:nTrain]...)

testImgs = MNIST.images(:test)
testLabels = MNIST.labels(:test)
nTest = length(testImgs)
testData = hcat([vcat(float.(testImgs[i])...) for i in 1:nTest]...)

@info "Training model with verbose output to $logFilePath."
@time begin
    sOut = stdout
    logF = open(logFilePath, "w")
    redirect_stdout(logF)
    model = svmtrain(trainData, trainLabels, 
                    kernel = Kernel.Linear, verbose=true)
    close(logF)
    redirect_stdout(sOut)
    @info "Training complete."
end

predicted_labels, _ = svmpredict(model, testData)

accuracy = sum(predicted_labels .== testLabels)/nTest
println("Prediction accuracy (measured on test set of size $nTest): ", accuracy)
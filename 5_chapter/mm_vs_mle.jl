using Distributions, PyPlot

min_n, step_n, max_n = 10, 10, 100
sampleSizes = min_n:step_n:max_n

MSE = Array{Float64}(undef, Int(max_n/step_n), 6)

trueB = 5
trueDist = Uniform(-2, trueB)
N = 10^4

MLEest(data) = maximum(data)
MMest(data)  = mean(data) + sqrt(3)*std(data)

for (index, n) in enumerate(sampleSizes)

    mleEst = Array{Float64}(undef, N)
    mmEst  = Array{Float64}(undef, N)
    for i in 1:N
        sample    = rand(trueDist,n)
        mleEst[i] = MLEest(sample)
        mmEst[i]  = MMest(sample)
    end
    meanMLE = mean(mleEst)
    meanMM  = mean(mmEst)
    varMLE  = var(mleEst)
    varMM   = var(mmEst)

    MSE[index,1] = varMLE + (meanMLE - trueB)^2
    MSE[index,2] = varMM + (meanMM - trueB)^2
    MSE[index,3] = varMLE
    MSE[index,4] = varMM
    MSE[index,5] = meanMLE - trueB
    MSE[index,6] = meanMM - trueB
end

figure("MM vs MLE comparrision", figsize=(12,4))
subplots_adjust(wspace=0.2)

subplot(131)
plot(sampleSizes,MSE[:,1],"xb",label="Mean sq.err (MLE)")
plot(sampleSizes,MSE[:,2],"xr",label="Mean sq.err (MM)")
xlabel("n")
legend(loc="upper right")

subplot(132)
plot(sampleSizes,MSE[:,3],"xb",label="Variance (MLE)")
plot(sampleSizes,MSE[:,4],"xr",label="Variance (MM)")
xlabel("n")
legend(loc="upper right")

subplot(133)
plot(sampleSizes,MSE[:,5],"xb",label="Bias (MLE)")
plot(sampleSizes,MSE[:,6],"xr",label="Bias (MM)")
xlabel("n")
legend(loc="center right")

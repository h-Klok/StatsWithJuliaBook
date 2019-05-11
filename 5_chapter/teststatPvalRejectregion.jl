using Random, Statistics, PyPlot
Random.seed!(2)

N = 10^7
n = 10
alpha = 0.05

function ts(n)
    sample = rand(n)
    return maximum(sample)-minimum(sample)
end

empricalDistUnderH0 = [ts(10) for _ in 1:N]
rejectionValue = quantile(empricalDistUnderH0,alpha)

sample = 0.75*rand(n)
testStat = maximum(sample)-minimum(sample)
pValue = sum(empricalDistUnderH0 .<= testStat)/N

if testStat > rejectionValue
    print("Didn't reject: ", round(testStat,digits=4))
    print(" > ", round(rejectionValue,digits=4))
else
    print("Reject: ", round(testStat,digits=4))
    print(" <= ", round(rejectionValue,digits=4))
end
println("\np-value = $(round(pValue,digits=4))")

plt.hist(empricalDistUnderH0,100, color="b", histtype="step", normed="true")
plot([testStat, testStat],[0,4],"r", label="Observed test \nstatistic")
plot([rejectionValue, rejectionValue],[0,4],"k--",
	label="Critical value \nboundary")
legend(loc="upper left")
ylim(0,4)

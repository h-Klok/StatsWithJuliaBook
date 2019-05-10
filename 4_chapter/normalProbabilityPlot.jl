using Random, PyPlot, Distributions, StatsBase
Random.seed!(0)
function normalProbabilityPlot(data, C, L)
        mu = mean(data)
        sig = std(data)
        n = length(data)
        p = [(i-0.5)/n for i in 1:n]
        x = quantile(Normal(),p)
        y = sort([(i-mu)/sig for i in data])
        plot(x, y, C, label=L)
        xRange = maximum(x) - minimum(x)
        plot( [minimum(x), maximum(x)],
                [minimum(x), maximum(x)], "k", lw=0.5)
        xlabel("Theoretical quantiles")
        ylabel("Quantiles of data")
        legend(loc="upper left")
end

normalData = randn(100)
expData = rand(Exponential(),100)

normalProbabilityPlot(normalData,".b","Normal data")
normalProbabilityPlot(expData,".r","Exponential data")

using DataFrames, GLM, PyPlot, Distributions, CSV

function normalProbabilityPlot(data)
        mu = mean(data)
        sig = std(data)
        n = length(data)
        p = [(i-0.5)/n for i in 1:n]
        x = quantile(Normal(),p)
        y = sort([(i-mu)/sig for i in data])
        plot(x, y, ".r")
        xRange = maximum(x) - minimum(x)
        plot( [minimum(x), maximum(x)],
                [minimum(x), maximum(x)], "k", lw=0.5)
        xlabel("Theoretical quantiles")
        ylabel("Quantiles of data")
end

data = CSV.read("weightHeight.csv")

model = lm(@formula(Height ~ Weight), data)
pred(x) = coef(model)'*[1, x]

residuals = data.Height - pred.(data.Weight)

figure(figsize=(8,4))
subplot(121)
plot(data.Weight, residuals,"b.")

subplot(122)
normalProbabilityPlot(data[:,3])

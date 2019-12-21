using CSV, Distributions, HypothesisTests

data = CSV.read("../data/machine1.csv", header=false)[:,1]
n, s, alpha = length(data), std(data), 0.1
ci = (  (n-1)*s^2/quantile(Chisq(n-1),1-alpha/2),
        (n-1)*s^2/quantile(Chisq(n-1),alpha/2)  )

println("Point estimate for the variance: ", s^2)
println("Confidence interval for the variance: ", ci)
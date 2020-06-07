using Random, Plots, Distributions, Measures; pyplot()

N = 5*10^3
alpha = 0.05
confLevel = 1 - alpha
z = quantile(Normal(),1-alpha/2) 

function randCI(n,p)
    sample = rand(n) .< p
    pHat = sum(sample)/n 
    serr = sqrt(pHat*(1-pHat)/n)
    (pHat - z*serr, pHat + z*serr) 
end
cover(p,ci) = ci[1] <= p && p <= ci[2]

pGrid = 0.1:0.01:0.9
nGrid = 5:1:50
errs = zeros(length(nGrid),length(pGrid))

for i in 1:length(nGrid)
    for j in 1:length(pGrid)
        Random.seed!(0)
        n, p = nGrid[i], pGrid[j]
        coverageRatio = sum([cover(p,randCI(n,p)) for _ in 1:N])/N
        errs[i,j] = confLevel - coverageRatio
    end
end

default(xlabel = "p", ylabel = "n", 
    xticks =([1:5:length(pGrid);], minimum(pGrid):0.05:maximum(pGrid)),
    yticks =([1:5:length(nGrid);], minimum(nGrid):5:maximum(nGrid)))

p1 = heatmap(errs, c=cgrad([:white, :black]))
p2 = heatmap(abs.(errs) .<= 0.04, legend = false, c=cgrad([:black, :white]))
plot(p1,p2, size = (1000,400), margin = 5mm)
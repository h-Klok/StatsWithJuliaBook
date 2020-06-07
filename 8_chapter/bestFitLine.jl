using DataFrames, Distributions, Random, LinearAlgebra, CSV, Plots; pyplot()
Random.seed!(0)

data = CSV.read("../data/L1L2data.csv")
xVals, yVals, n = data.X, data.Y, size(data)[1]

N = 10^6
alphaMin, alphaMax, betaMin, betaMax = 0, 5, 0, 5

alpha1, beta1, alpha2, beta2, bestL1Cost, bestL2Cost = 0.0,0.0,0.0,0.0,Inf,Inf
for _ in 1:N
    rAlpha,rBeta=rand(Uniform(alphaMin,alphaMax)),rand(Uniform(betaMin,betaMax))
    L1Cost = norm(rAlpha .+ rBeta*xVals - yVals,1)
    if L1Cost < bestL1Cost
        global alpha1 = rAlpha
        global beta1 = rBeta
        global bestL1Cost = L1Cost
    end
    L2Cost = norm(rAlpha .+ rBeta*xVals  - yVals)
    if L2Cost < bestL2Cost
        global alpha2 = rAlpha
        global beta2 = rBeta
        global bestL2Cost = L2Cost
    end
end

println("L1 line: $(round(alpha1,digits = 2)) + $(round(beta1,digits = 2))x")
println("L2 line: $(round(alpha2,digits = 2)) + $(round(beta2,digits = 2))x")

d = yVals - (alpha2 .+ beta2*xVals)
rectangle(x, y, d) = Shape(x .- [0,d,d,0,0], y .- [0,0,d,d,0])

p1 = scatter(xVals,yVals, c=:black, ms=5, label="")
p1 = plot!([0,10],[alpha1, alpha1 .+ beta1*10], c=:blue,label="L1 minimized")
for i in 1:n
    x,y = xVals[i],yVals[i]
    p1 = plot!([x, x], [y, alpha1 .+ beta1*x],color="black", label="")
end

p2 = scatter(xVals,yVals, c=:black, ms=5, label="")
p2 = plot!([0,10],[alpha2, alpha2 .+ beta2*10],c=:red,label="L2 minimized")
for i in 1:n
    x,y = xVals[i],yVals[i]
	p2 = plot!(rectangle(x,y,d[i]), fc=:gray, fa=0.5, label="")
end

p3 = scatter(xVals,yVals, c=:black, ms=5, label="")
p3 = plot!([0,10],[alpha1, alpha1 .+ beta1*10], c=:blue, label="L1 minimized")
p3 = plot!([0,10],[alpha2, alpha2 .+ beta2*10], c=:red, label="L2 minimized")

plot(p1, p2, p3, layout = (1,3), 
	ratio=:equal, xlims=(0,10), ylims=(0,10), 
	legend=:topleft, size=(1200, 400),
    	xlabel = "x", ylabel = "y")
using DataFrames, Distributions, PyPlot, PyCall, Random, LinearAlgebra, CSV

patch = pyimport("matplotlib.patches")
line = pyimport("matplotlib.lines")
Random.seed!(0)
data = CSV.read("L1L2data.csv")
xVals, yVals = data.X, data.Y
n, N = 5 , 10^6
alphaMin, alphaMax, betaMin, betaMax = 0, 5, 0, 5
alpha1, beta1, alpha2, beta2, bestL1Cost, bestL2Cost = 0.0,0.0,0.0,0.0,Inf,Inf
for _ in 1:N
    rAlpha,rBeta=rand(Uniform(alphaMin,alphaMax)),rand(Uniform(betaMin,betaMax))
    L1Cost = norm(rAlpha .+ rBeta*xVals - yVals,1)
    if L1Cost < bestL1Cost
        alpha1 = rAlpha
        beta1 = rBeta
        bestL1Cost = L1Cost
    end
    L2Cost = norm(rAlpha .+ rBeta*xVals  - yVals)
    if L2Cost < bestL2Cost
        alpha2 = rAlpha
        beta2 = rBeta
        bestL2Cost = L2Cost
    end
end

fig = figure(figsize=(12,4))
ax1 = fig.add_subplot(1,3,1)
ax1.set_aspect("equal")
plot(xVals,yVals,"k.",ms=10)
plot([0,10],[alpha1, alpha1 .+ beta1*10],"b",label="L1 minimized")
legend(loc="upper left")
xlim(0,10);ylim(0,10)

ax2 = fig.add_subplot(1,3,2)
ax2.set_aspect("equal")
plot(xVals,yVals,"k.",ms=10)
plot([0,10],[alpha2, alpha2 .+ beta2*10],"r",label="L2 minimized")
legend(loc="upper left")
xlim(0,10);ylim(0,10)

ax3 = fig.add_subplot(1,3,3)
ax3.set_aspect("equal")
plot(xVals,yVals,"k.",ms=10)
plot([0,10],[alpha1, alpha1 .+ beta1*10],"b",label="L1 minimized")
plot([0,10],[alpha2, alpha2 .+ beta2*10],"r",label="L2 minimized")
legend(loc="upper left")
xlim(0,10);ylim(0,10)

d = yVals - (alpha2 .+ beta2*xVals)
for i in 1:n
    x,y = xVals[i],yVals[i]
    l=line.Line2D([x, x], [y, alpha1 .+ beta1*x], lw=1,color="black")
    r=patch.Rectangle([x,y],-d[i],-d[i],lw=1,ec="black",fc="black",alpha=0.5)
    ax1.add_artist](l);ax2[:add_artist(r)
end
println("L1 line: $(round(alpha1,digits = 2)) + $(round(beta1,digits = 2))x")
println("L2 line: $(round(alpha2,digits = 2)) + $(round(beta2,digits = 2))x")

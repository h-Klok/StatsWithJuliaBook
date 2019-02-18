using Distributions, PyPlot, Random
Random.seed!(1)

X0, T, a = 70.0, 120, 0.8
spikeTime, spikeSize = 40, 50
varX, varY = 0.36, 1.0
alpha, beta = 0.8, 0.3

X, Xhat = X0, 0.0
xTraj, xHatTraj = [X], [Xhat]

for t in 1:T
    X = a*X + rand(Normal(0,sqrt(varX)))
    Y = X + rand(Normal(0,sqrt(varY)))
    Xhat = alpha*Xhat + beta*(Y-Xhat)

    push!(xTraj,X)
    push!(xHatTraj,Xhat)

    if t == spikeTime
        X += spikeSize
    end
end

figure("MM vs MLE comparision", figsize=(12,4))
subplot(121)
plot(xTraj,"b.",label="Actual")
plot(xHatTraj,"r.",label="Predicted")
xlabel("Time");ylabel("X")
xlim(0, 120)
legend(loc="upper right")

subplot(122)
plot(xTraj,"b.",label="Actual")
plot(xHatTraj,"r.",label="Predicted")
xlim(50, 100);ylim(-6,6)
xlabel("Time");ylabel("X")
legend(loc="upper right");
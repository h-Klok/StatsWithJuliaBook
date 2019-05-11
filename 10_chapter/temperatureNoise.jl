using Distributions, PyPlot, Random
Random.seed!(1)

X0, T, a = 70.0, 120, 0.8
spikeTime, spikeSize = 40, 50
varX, varY = 0.36, 1.0
alpha, k = 0.8, 0.3

X, Xhat = X0, 0.0
xTraj, xHatTraj = [X], [Xhat]

for t in 1:T
    global X = a*X + rand(Normal(0,sqrt(varX)))
    global Y = X + rand(Normal(0,sqrt(varY)))
    global Xhat = alpha*Xhat + k*(Y-Xhat)

    push!(xTraj,X)
    push!(xHatTraj,Xhat)

    if t == spikeTime
        global X += spikeSize
    end
end

figure("MM vs MLE comparision", figsize=(12,4))
subplot(121)
plot(xTraj,"b.",label="System trajectory")
plot(xHatTraj,"r.",label="Kalman filter tracking")
xlabel("Time");ylabel("X")
xlim(0, 120)
legend(loc="upper right")

subplot(122)
plot(xTraj,"b.",label="System trajectory")
plot(xHatTraj,"r.",label="Kalman filter tracking")
xlim(50, 100);ylim(-6,6)
xlabel("Time");ylabel("X")
legend(loc="upper right")

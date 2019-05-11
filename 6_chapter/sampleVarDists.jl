using Distributions, PyPlot

std, n, N = 3, 15, 10^7
dNormal   = Normal(2,std)
dLogistic = Logistic(2,sqrt(std^2*3)/pi)
xGrid = -8:0.1:12

sNormal   = [var(rand(dNormal,n)) for _ in 1:N]
sLogistic = [var(rand(dLogistic,n)) for _ in 1:N]

figure(figsize=(12.4,4))
subplot(121)
plot(xGrid, pdf(dNormal,xGrid), "b",label="Normal")
plot(xGrid, pdf(dLogistic,xGrid), "r",label="Logistic")
xlabel("x")
legend(loc="upper right")
xlim(-8,12)
ylim(0,0.16)

subplot(122)
plt.hist(sNormal,200,color="b",histtype="step",normed=true,
    label="Normal")
plt.hist(sLogistic,200,color="r",histtype="step",normed=true,
    label="Logistic")
xlabel("Sample Variance")
legend(loc="upper right")
xlim(0,30)
ylim(0,0.14)

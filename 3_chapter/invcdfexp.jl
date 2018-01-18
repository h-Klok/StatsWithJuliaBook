using Distributions, PyPlot

expDist = Exponential(2)
x = 0:0.1:10
x2 = 0:0.01:0.99

figure(figsize=(14,4))

subplot(131)
plot(x,pdf(expDist,x))
xlabel("x")
ylabel("P(x)")
title("PDF of e^-2x")

subplot(132)
plot(x,cdf(expDist,x))
plot([quantile(expDist,0.5),quantile(expDist,0.5)],[0,0.5],"r")
plot([0,quantile(expDist,0.5)],[0.5,0.5],"r")
xlabel("x")
ylabel("P(X <= x)")
title("CDF of e^-2x")

subplot(133)
plot(x2,quantile(expDist,x2))
plot([0.5,0.5],[0,quantile(expDist,0.5)],"r")
plot([0,0.5],[quantile(expDist,0.5),quantile(expDist,0.5)],"r")
xlabel("P(X <= x)")
ylabel("x")
title("Inv CDF of e^-2x")

savefig("invcdfexp.png")

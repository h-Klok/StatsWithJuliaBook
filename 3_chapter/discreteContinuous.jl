using PyPlot

pDiscrete = [0.25, 0.25, 0.5]
xGridD = 0:2

pContinuous(x) = 3/4*(1 - x^2)
xGridC = -1:0.01:1

pContinuous2(x) = x < 0 ? x+1 : 1-x

figure(figsize=(12.4,4))
subplots_adjust(wspace=0.4)

subplot(131)
stem(xGridD,pDiscrete,basefmt="none")
ylim(0,1.1)
xlabel("x")
ylabel("Probability")

subplot(132)
plot(xGridC,pContinuous.(xGridC))
ylim(0,1.1)
xlabel("x")
ylabel("Density")

subplot(133)
plot(xGridC,pContinuous2.(xGridC))
ylim(0,1.1)
xlabel("x")
ylabel("Density")

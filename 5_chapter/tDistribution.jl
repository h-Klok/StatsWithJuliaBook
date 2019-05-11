using Distributions, PyPlot

xGrid = -5:0.1:5
plot(xGrid, pdf(Normal(), xGrid), "k",  label="Normal Distribution")
plot(xGrid, pdf(TDist(1) ,xGrid), "b.", label="DOF = 1")
plot(xGrid, pdf(TDist(3), xGrid), "r.", label="DOF = 3")
plot(xGrid, pdf(TDist(100),xGrid),"g.", label="DOF = 100")
xlim(-4,4)
ylim(0,0.5)
xlabel("X")
ylabel("Probability")
legend(loc="upper right")

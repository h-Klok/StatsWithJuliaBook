using Distributions, Calculus ,PyPlot

xGrid = -5:0.01:5
sig = 1.5
normalDensity(z) = pdf(Normal(0,sig),z)

d0 = normalDensity.(xGrid)
d1 = derivative.(normalDensity,xGrid)
d2 = second_derivative.(normalDensity, xGrid)

ax = gca()
plot(xGrid,d0,"b",label="f(x)")
plot(xGrid,d1,"r",label="f'(x)")
plot(xGrid,d2,"g",label="f''(x)")
plot([-5,5],[0,0],"k", lw=0.5)
xlabel("x")
xlim(-5,5)
legend(loc="upper right")

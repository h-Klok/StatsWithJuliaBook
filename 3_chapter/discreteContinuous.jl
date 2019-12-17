using Plots, Measures; pyplot()

pDiscrete = [0.25, 0.25, 0.5]
xGridD = 0:2

pContinuous(x) = 3/4*(1 - x^2)
xGridC = -1:0.01:1

pContinuous2(x) = x < 0 ? x+1 : 1-x

p1 = plot(xGridD, line=:stem, pDiscrete, marker=:circle, c=:blue, ms=6, msw=0)
p2 = plot(xGridC, pContinuous.(xGridC), c=:blue)
p3 = plot(xGridC, pContinuous2.(xGridC), c=:blue)

plot(p1, p2, p3, layout=(1,3), legend=false, ylims=(0,1.1), xlabel="x",
	ylabel=["Probability" "Density" "Density"], size=(1200, 400), margin=5mm)

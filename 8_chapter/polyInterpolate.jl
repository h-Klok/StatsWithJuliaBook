using Plots; pyplot()

xVals = [-2,3,5,6,12,14]
yVals = [7,2,9,3,12,3]
n = length(xVals)

V = [xVals[i+1]^(j) for i in 0:n-1, j in 0:n-1]
c = V \ yVals
xGrid = -5:0.01:20
f1(x) = c'*[x^i for i in 0:n-1]

beta0, beta1 = 4.58, 0.17
f2(x) = beta0 + beta1*x

plot(xGrid,f1.(xGrid), c=:blue, label="Polynomial 5th order")
plot!(xGrid,f2.(xGrid),c=:red, label="Linear model")
scatter!(xVals,yVals,
	c=:black, shape=:xcross, ms=8, 
	label="Data points", xlims=(-5,20), ylims=(-50,50),
    	xlabel = "x", ylabel = "y")
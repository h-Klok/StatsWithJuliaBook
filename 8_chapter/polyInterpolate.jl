using PyPlot

xVals = [-2,3,5,6,12,14]
yVals = [7,2,9,3,12,3]
n = length(xVals)

V = [xVals[i+1]^(j) for i in 0:n-1, j in 0:n-1]
c = V\yVals
xGrid = -5:0.01:20
f1(x) = c'*[x^i for i in 0:n-1]

beta0, beta1 = 4.58, 0.17
f2(x) = beta0 + beta1*x

plot(xGrid,f1.(xGrid),"b",label="Polynomial 5th order")
plot(xGrid,f2.(xGrid),"r",label="Linear model")
plot(xVals,yVals,"kx",ms="10",label="Data points")
xlim(-5,20)
ylim(-50,50)
legend(loc="upper right")

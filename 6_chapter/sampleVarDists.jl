using Distributions, Plots; pyplot()

mu, sig = 2, 3
eta = sqrt(3)*sig/pi
n, N = 15, 10^7
dNormal   = Normal(mu, sig)
dLogistic = Logistic(mu, eta)
xGrid = -8:0.1:12

sNormal   = [var(rand(dNormal,n)) for _ in 1:N]
sLogistic = [var(rand(dLogistic,n)) for _ in 1:N]

p1 = plot(xGrid, pdf.(dNormal,xGrid), c=:blue, label="Normal")
p1 = plot!(xGrid, pdf.(dLogistic,xGrid), c=:red, label="Logistic", 
	xlabel="x",ylabel="Density", xlims= (-8,12), ylims=(0,0.16))

p2 = stephist(sNormal, bins=200, c=:blue, normed=true, label="Normal")
p2 = stephist!(sLogistic, bins=200, c=:red, normed=true, label="Logistic", 
	xlabel="Sample Variance", ylabel="Density", xlims=(0,30), ylims=(0,0.14))

plot(p1, p2, size=(800, 400))
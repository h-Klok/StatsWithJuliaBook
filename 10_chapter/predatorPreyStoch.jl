using Distributions, Random, Plots, LaTeXStrings; pyplot()
Random.seed!(1)

a, c, d = 2, 1, 5
sig = 0.02
next(x,y) = [a*x*(1-x) - x*y, -c*y + d*x*y]
equibPoint = [(1+c)/d ,(d*(a-1)-a*(1+c))/d]

initX = [0.8,0.05]
tEnd,tEndStoch = 100, 10

traj = [[] for _ in 1:tEnd]
trajStoch = [[] for _ in 1:tEndStoch]
traj[1], trajStoch[1] = initX, initX

for t in 2:tEnd
    traj[t] =  next(traj[t-1]...)
end

for t in 2:tEndStoch
    trajStoch[t] = next(trajStoch[t-1]...) + [rand(Normal(0,sig)),0.0]
end

scatter([traj[1][1]], [traj[1][2]], 
	c=:black, ms=10, label="Initial state")
plot!(first.(traj), last.(traj), 
	c=:blue, ls=:dash, m=(:dot, 5, Plots.stroke(0)), 
	label="Deterministic trajectory")
plot!(first.(trajStoch),last.(trajStoch), 
	c=:green, ls=:dash, m=(:dot, 5, Plots.stroke(0)), 
	label="Stochastic trajectory")
scatter!([equibPoint[1]], [equibPoint[2]], 
	c=:red, shape=:cross, ms=10, label="Equlibrium point", 
	xlabel=L"X_1", ylabel=L"X_2")
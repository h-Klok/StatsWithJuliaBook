using Plots, LaTeXStrings; pyplot()

a, c, d = 2, 1, 5
next(x,y) = [a*x*(1-x) - x*y, -c*y + d*x*y]
equibPoint = [(1+c)/d ,(d*(a-1)-a*(1+c))/d]

initX = [0.8,0.05]
tEnd = 100

traj = [[] for _ in 1:tEnd]
traj[1] = initX

for t in 2:tEnd
    traj[t] = next(traj[t-1]...)
end

scatter([traj[1][1]], [traj[1][2]], 
	c=:black, ms=10, 
	label="Initial state")
plot!(first.(traj),last.(traj),
	c=:blue, ls=:dash, m=(:dot, 5, Plots.stroke(0)), 
	label="Model trajectory")
scatter!([equibPoint[1]], [equibPoint[2]], 
	c=:red, shape=:cross, ms=10, label="Equlibrium point", 
	xlabel=L"X_1", ylabel=L"X_2")
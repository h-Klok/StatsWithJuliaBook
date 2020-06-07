using DifferentialEquations, LinearAlgebra, Plots; pyplot()

k, b, M = 1.2, 0.3, 2.0
A = [0 1;
    -k/M -b/M]

initX = [8., 0.0]
tEnd = 50.0
tRange = 0:0.1:tEnd

manualSol = [exp(A*t)*initX for t in tRange]

linearRHS(x,Amat,t) = Amat*x
prob = ODEProblem(linearRHS, initX, (0,tEnd), A)
sol = solve(prob)

p1 = plot(first.(manualSol), last.(manualSol),
	c=:blue, label="Manual trajectory")
p1 = scatter!(first.(sol.u), last.(sol.u),
	c=:red, ms = 5, msw=0, label="DiffEq package")
p1 = scatter!([initX[1]], [initX[2]],
	c=:black, ms=10, label="Initial state",	xlims=(-7,9), ylims=(-9,7),
	ratio=:equal, xlabel="Displacement", ylabel="Velocity")
p2 = plot(tRange, first.(manualSol),
	c=:blue, label="Manual trajectory")
p2 = scatter!(sol.t, first.(sol.u),
	c=:red, ms = 5, msw=0, label="DiffEq package")
p2 = scatter!([0], [initX[1]],
	c=:black, ms=10, label="Initial state", xlabel="Time",
	ylabel="Displacement")
plot(p1, p2, size=(800,400), legend=:topright)
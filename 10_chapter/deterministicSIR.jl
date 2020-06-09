using DifferentialEquations, Plots; pyplot()

beta = 0.04
gamma = 0.01
delta = 0.3

#S, E, I, R
initX = [0.9, 0.0, 0.1, 0.0]
tEnd = 400.0

RHS(x,parms,t) = [
                -beta*x[1]*x[3],
                beta*x[1]*x[3] - delta*x[2],
                delta*x[2] - gamma*x[3],
                gamma*x[3]]

prob = ODEProblem(RHS, initX, (0,tEnd), 0)
sol = solve(prob)

plot(sol.t,((x)->x[1]).(sol.u),label = "S")
plot!(sol.t,((x)->x[2]).(sol.u),label = "E")
plot!(sol.t,((x)->x[3]).(sol.u),label = "I")
plot!(sol.t,((x)->x[4]).(sol.u),label = "R",
    xlabel = "Time", ylabel = "Proportion",legend = :top)
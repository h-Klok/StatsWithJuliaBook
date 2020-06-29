using DifferentialEquations, Plots; pyplot()

beta, delta, gamma = 0.25, 0.2, 0.1
initialInfect = 0.025
println("R0 = ", beta/gamma)

initX = [1-initialInfect, 0.0, initialInfect, 0.0]
tEnd = 100.0

RHS(x,parms,t) = [  -beta*x[1]*x[3],
                    beta*x[1]*x[3] - delta*x[2],
                    delta*x[2] - gamma*x[3],
                    gamma*x[3] ]

prob = ODEProblem(RHS, initX, (0,tEnd), 0)
sol = solve(prob)
println("Final infected proportion= ", sol.u[end][4])

plot(sol.t,((x)->x[1]).(sol.u),label = "Susceptible", c=:green)
plot!(sol.t,((x)->x[2]).(sol.u),label = "Exposed", c=:blue)
plot!(sol.t,((x)->x[3]).(sol.u),label = "Infected", c=:red)
plot!(sol.t,((x)->x[4]).(sol.u),label = "Removed", c=:yellow,
    xlabel = "Time", ylabel = "Proportion",legend = :top)

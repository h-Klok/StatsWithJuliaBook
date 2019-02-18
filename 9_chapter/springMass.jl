using DifferentialEquations, PyPlot, LinearAlgebra

k, b, M = 1.2, 0.3, 2.0
A = [0 1;
    -k/M -b/M]

initX = [8.,0.0]
tEnd = 50.0;
tRange = 0:0.1:tEnd

manualSol = [exp(A*t)*initX for t in tRange]

linearRHS(x,Amat,t) = Amat*x 
prob = ODEProblem(linearRHS, initX, (0,tEnd),A)
sol = solve(prob)

figure(figsize=(10,5))
subplot(121)
xlim(-7,9);ylim(-9,7)
plot(first.(manualSol),last.(manualSol),"b")
plot(first.(sol.u),last.(sol.u),"r.")
plot(initX[1],initX[2],"g.",ms="15")
xlabel("Displacement"); ylabel("Velocity")

subplot(122)
plot(tRange,first.(manualSol),"b")
plot(sol.t,first.(sol.u),"r.")
plot(0,initX[1],"g.",ms="15");
xlabel("Time"); ylabel("Displacement")
using StatsBase, Distributions, Random, LinearAlgebra
Random.seed!(1)

function crudeSimulation(deltaT,T,Q,initProb)
    n = size(Q)[1]
    Pdelta = I + Q*deltaT
    state  = sample(1:n,weights(initProb))
    t = 0.0
    while t < T
        t += deltaT
        state = sample(1:n,weights(Pdelta[state,:]))
    end
    return state
end

function doobGillespie(T,Q,initProb)
    n = size(Q)[1]
    Pjump  = (Q-diagm(0 => diag(Q)))./-diag(Q)
    lamVec = -diag(Q)
    state  = sample(1:n,weights(initProb))
    sojournTime = rand(Exponential(1/lamVec[state]))
    t = 0.0
    while t + sojournTime < T
        t += sojournTime
        state = sample(1:n,weights(Pjump[state,:]))
        sojournTime = rand(Exponential(1/lamVec[state]))
    end
    return state
end

T, N = 0.25, 10^5

Q = [-3 1 2
     1 -2 1
     0 1.5 -1.5]

p0 = [0.4 0.5 0.1]

crudeSimEst = counts([crudeSimulation(10^-3., T, Q, p0) for _ in 1:N])/N
doobGillespieEst = counts([doobGillespie(T, Q, p0) for _ in 1:N])/N
explicitEst = p0*exp(Q*T)

println("CrudeSim: \t\t", crudeSimEst)
println("Doob Gillespie Sim: \t", doobGillespieEst)
println("Explicit: \t\t", explicitEst)

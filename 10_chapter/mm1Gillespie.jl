using Distributions, Random, Plots; pyplot()
Random.seed!(4)

function simulateMM1DoobGillespie(lambda,mu,Q0,T)
    t, Q = 0.0 , Q0
    tValues, qValues = [0.0], [Q0]
    while t<T
        if Q == 0
            t += rand(Exponential(1/lambda))
            Q = 1
        else
            t += rand(Exponential(1/(lambda+mu)))
            Q += 2(rand() < lambda/(lambda+mu)) -1
        end
        push!(tValues,t)
        push!(qValues,Q)
    end
    return [tValues, qValues]
end

function stichSteps(epochs,q)
    n = length(epochs)
    newEpochs  = [ epochs[1] ]
    newQ = [ q[1] ]
    for i in 2:n
        push!(newEpochs,epochs[i])
        push!(newQ,q[i-1])
        push!(newEpochs,epochs[i])
        push!(newQ,q[i])
    end
    return [newEpochs, newQ]
end

lambda, mu = 0.7, 1.0
Tplot, Testimation = 200, 10^7
Q0 = 20

eL,qL = simulateMM1DoobGillespie(lambda, mu ,Q0, Testimation)
meanQueueLength = (eL[2:end]-eL[1:end-1])'*qL[1:end-1]/last(eL)
rho = lambda/mu
println("Estimated mean queue length: ", meanQueueLength )
println("Theoretical mean queue length: ", rho/(1-rho) )

epochs, qValues = simulateMM1DoobGillespie(lambda, mu, Q0,Tplot)
epochsForPlot, qForPlot = stichSteps(epochs,qValues)
plot(epochsForPlot,qForPlot, 
	c=:blue, xlims=(0,Tplot), ylims=(0,25), xlabel="Time",
	ylabel="Customers in queue", legend=:none)
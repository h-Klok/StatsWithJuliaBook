using Distributions, Random, Plots; pyplot()
Random.seed!(0)

beta, delta, gamma = 0.25, 0.4, 0.1
initialInfect = 0.025
M = 1000
I0 = Int(floor(initialInfect*M))
N = 30

function simulateSIRDoobGillespie(beta,delta,gamma,I0,M,T)
    t, S, E, I, R = 0.0, M-I0, 0, I0, 0
    tValues, sValues, eValues, iValues, rValues = [0.0], [S], [E], [I], [R]
    while t<T
        infectionRate = beta*I*S
        symptomRate = delta*E
        removalRate = gamma*I
        totalRate = infectionRate + symptomRate + removalRate
        probs = [infectionRate, symptomRate, removalRate]/totalRate
        t += rand(Exponential(1/(totalRate)))
        u = rand()
        if u < probs[1]
            S -= 1; E += 1
        elseif u < probs[1] + probs[2]
            E -=1; I+=1
        else
            I -= 1; R += 1
        end
        push!(tValues,t)
        push!(sValues,S);push!(eValues,E);push!(iValues,I);push!(rValues,R)
        I == 0 && break
    end
    return [tValues, sValues, eValues, iValues, rValues]
end

tV,sV,eV,iV,rV = simulateSIRDoobGillespie(beta/M,delta,gamma,I0,M,Inf)
lastT = tV[end]

finals = [simulateSIRDoobGillespie(beta/M,delta,gamma,I0,M,Inf)[5][end] 
                for _ in 1:N]/M

p1 = plot(tV,sV/M,label = "Susceptible", c=:green)
plot!(tV,eV/M,label = "Exposed", c=:blue)
plot!(tV,iV/M,label = "Infected",c=:red)
plot!(tV,rV/M,label = "Removed", c=:yellow,
    xlabel = "Time", ylabel = "Proportion",
    legend = :topleft, xlim = (0,lastT*1.05))
scatter!(lastT*1.025*ones(N),finals, c = :yellow,label= "Final Infected")
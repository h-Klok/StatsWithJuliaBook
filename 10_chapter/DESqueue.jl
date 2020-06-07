using Distributions, Random
Random.seed!(1)

function queueDES(T, arrF, serF, capacity = Inf, initQ = 0)
    t, q, qL = 0.0, initQ, 0.0

    nextArr, nextSer = arrF(), q == 0 ? Inf : serF()
    while t < T
        tPrev, qPrev = t, q
        if nextSer < nextArr
            t = nextSer
            q -= 1
            if q > 0
                nextSer = t + serF()
            else
                nextSer = Inf
            end
        else
            t = nextArr
            if q == 0
                nextSer = t + serF()
            end
            if q < capacity
                q += 1
            end
            nextArr = t + arrF()
        end
        qL += (t - tPrev)*qPrev
    end
    return qL/t
end

lam, mu, K = 0.82, 1.3, 5
rho = lam/mu
T = 10^6

mm1Theor = rho/(1-rho)
md1Theor = rho/(1-rho)*(2-rho)/2
mm1kTheor = rho/(1-rho)*(1-(K+1)*rho^K+K*rho^(K+1))/(1-rho^(K+1))

mm1Est = queueDES(T,()->rand(Exponential(1/lam)),
            			  ()->rand(Exponential(1/mu)))
md1Est = queueDES(T,()->rand(Exponential(1/lam)),
                                   ()->1/mu)
mm1kEst = queueDES(T,()->rand(Exponential(1/lam)),
                                      ()->rand(Exponential(1/mu)), K)

println("The load on the system: ",rho)
println("Queueing theory: ", (mm1Theor,md1Theor,mm1kTheor) )
println("Via simulation: ", (mm1Est,md1Est,mm1kEst) )
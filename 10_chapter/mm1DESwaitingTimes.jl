using DataStructures,Distributions,StatsBase,Random,Plots, LaTeXStrings; pyplot()

function simMM1Wait(lambda,mu,T)
    tNextArr = rand(Exponential(1/(lambda)))
    tNextDep = Inf
    t = tNextArr

    waitingRoom = Queue{Float64}()
    serverBusy = false
    waitTimes = Array{Float64,1}()

    while t<T
        if t == tNextArr
            if !serverBusy
                tNextDep = t + rand(Exponential(1/mu))
                serverBusy = true
                push!(waitTimes,0.0)
            else
                enqueue!(waitingRoom,t)
            end
            tNextArr = t + rand(Exponential(1/(lambda)))
        else
            if length(waitingRoom) == 0
               tNextDep = Inf
               serverBusy = false
            else
               tArr = dequeue!(waitingRoom)
               waitTime = t - tArr
               push!(waitTimes, waitTime)
               tNextDep = t + rand(Exponential(1/mu))
            end
        end
        t = min(tNextArr,tNextDep)
    end

    return waitTimes
end

Random.seed!(1)
lambda, mu = 0.8, 1.0
T = 10^3

data = simMM1Wait(lambda,mu,T)
empiricalCDF = ecdf(data)

F(x) = 1-(lambda/mu)*MathConstants.e^(-(mu-lambda)x)
xGrid = 0:0.1:20

plot(xGrid, F.(xGrid),
	c=:blue,label="Analytic CDF of waiting time")
plot!(xGrid, empiricalCDF(xGrid),
	c=:red,label="ECDF of waiting times",  
	xlabel=L"x", ylabel=L"\Prob(W \leq x)", xlims=(0,20),ylims=(0,1),
	legend=:bottomright)
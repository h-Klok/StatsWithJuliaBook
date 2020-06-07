using Statistics, StatsBase, Random, LinearAlgebra
Random.seed!(1)

function cmHitTime()
    catIndex, mouseIndex, t = 1, 5, 0
        while catIndex != mouseIndex
            catIndex += catIndex == 1 ? 1 : rand([-1,1])
            mouseIndex += mouseIndex == 5 ? -1 : rand([-1,1])
            t += 1
        end
    return t
end
function mcTraj(P,initState,T,stopState=0)
    n = size(P)[1]
    state = initState
    traj = [state]
    for t in 1:T-1
        state = sample(1:n,weights(P[state,:]))
        push!(traj,state)
        if state == stopState
            break
        end
    end
    return traj
end
N = 10^6
P = [   0   1   0   0   0;
        1/4 0   1/4 1/4 1/4;
        0   1/2 0   0   1/2;
        0   1/2 0   0   1/2;
        0   0   0   0   1]

theor = [1 0 0 0] * (inv(I - P[1:4,1:4])*ones(4))
est1 = mean([cmHitTime() for _ in 1:N])
est2 = mean([length(mcTraj(P,1,10^6,5))-1 for _ in 1:N])

P[5,:] = [1 0 0 0 0]
pi5 = sum(mcTraj(P,1,N) .== 5)/N
est3 = 1/pi5 - 1

println("Theoretical: ", theor)
println("Estimate 1: ",est1)
println("Estimate 2: ",est2)
println("Estimate 3: ",est3)

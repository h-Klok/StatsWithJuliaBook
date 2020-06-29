using LinearAlgebra, Statistics, StatsBase, Plots; pyplot()

n, N = 5, 10^6
P = diagm(-1 => fill(1/3,n-1),
           0 => fill(1/3,n),
           1 => fill(1/3,n-1))
P[1,n], P[n,1] = 1/3, 1/3

A = UpperTriangular(ones(n,n))
C = P*A

function f1(x,u)
    for xNew in 1:n
        if u <= C[x+1,xNew]
            return xNew-1
        end
    end
end

f2(x,xi) = mod(x + xi , n)

function countTau(f,rnd)
    t = 0
    visits = fill(false,n)
    state = 0
    while sum(visits) < n
        state = f(state,rnd())
        visits[state+1] |= true
        t += 1
    end
    return t-1
end

data1 = [countTau(f1,rand) for _ in 1:N]
data2 = [countTau(f2,()->rand([-1,0,1]) ) for _ in 1:N]
est1, est2 = mean(data1), mean(data2)
c1, c2 = counts(data1)/N,counts(data2)/N
println("Estimated mean value of tau using f1: ",est1)
println("Estimated mean value of tau using f2: ",est2)
println("\nThe matrix P:", P)
scatter(4:33,c1[1:30], 
	c=:blue, ms=5, msw=0, 
	label="Transition probability matrix")
scatter!(4:33,c2[1:30], 
	c=:red, ms=5, msw=0, shape=:cross, 
	label="Stochastic recursive formula", xlabel="Time", ylabel="Probability")
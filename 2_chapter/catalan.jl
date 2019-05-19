using Random, Combinatorics, PyPlot
Random.seed!(1)

n, N = 5, 10^5
function isUpperLattice(v)
    for i in 1:Int(length(v)/2)
        sum(v[1:2*i-1]) >= i ? continue : return false && break
    end
    return true
end
function plotPath(v,l,c)
    x,y = 0,0
    graphX, graphY = [x], [y]
    for i in v
        if i == 0
            x += 1
        else
            y += 1
        end
        push!(graphX,x), push!(graphY,y)
    end
    plot(graphX,graphY,alpha=0.8,label=l, lw=2, c=c)
end
omega = unique(permutations([zeros(Int,n);ones(Int,n)]))
A = omega[isUpperLattice.(omega)]
Ac = setdiff(omega,A)
figure(figsize=(5,5))
plotPath(rand(A),"Upper lattice path","b")
plotPath(rand(Ac),"Non-upper lattice path","r")
legend(loc="upper left")
plot([0, n], [0,n], ls="--","k")
xlim(0,n)
ylim(0,n)
grid("on")
pA_modelI = length(A)/length(omega)
function randomWalkPath(n)
    x, y = 0, 0
    path = []
    while x<n && y<n
       if rand()<0.5
            x += 1
            push!(path,0)
        else
            y += 1
            push!(path,1)
        end
    end
    if x < n
        append!(path,zeros(Int64,n-x))
    else
        append!(path,ones(Int64,n-y))
    end
    return path
end
pA_modelIIest = sum([isUpperLattice(randomWalkPath(n)) for _ in 1:N])/N
pA_modelI, pA_modelIIest

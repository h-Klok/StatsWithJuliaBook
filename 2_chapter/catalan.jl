using Random, Combinatorics, Plots, LaTeXStrings ; pyplot()
Random.seed!(12)

n, N = 5, 10^5

function isUpperLattice(v)
    for i in 1:Int(length(v)/2)
        sum(v[1:2*i-1]) >= i ? continue : return false
    end
    return true
end

omega = unique(permutations([zeros(Int,n);ones(Int,n)]))
A = omega[isUpperLattice.(omega)]
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
    append!(path, x<n ? zeros(Int64,n-x) : ones(Int64,n-y))
    return path
end

pA_modelIIest = sum([isUpperLattice(randomWalkPath(n)) for _ in 1:N])/N
println("Model I: ",pA_modelI, "\t Model II: ", pA_modelIIest)

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
    plot!(graphX, graphY, 
            la=0.8, lw=2, label=l, c=c, ratio=:equal, legend=:topleft, 
            xlims=(0,n), ylims=(0,n), 
            xlabel=L"East\rightarrow", ylabel=L"North\rightarrow")
end
plot()
plotPath(rand(A), "Upper lattice path", :blue)
plotPath(rand(setdiff(omega,A)), "Non-upper lattice path", :red)
plot!([0, n], [0,n], ls=:dash, c=:black, label="")
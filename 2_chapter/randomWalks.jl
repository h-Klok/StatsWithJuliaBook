using PyPlot

function randomWalk(seed,p)
    srand(seed)
    xTraj = Array{Int64}(100)
    yTraj = Array{Int64}(100)
    xTraj[1], yTraj[1] = 0, 0
    
    for t in 2:100
        xTraj[t] = xTraj[t-1] + (p < rand())
        yTraj[t] = yTraj[t-1] + (p < rand())
    end
    plot(xTraj,yTraj,label="Seed = $seed, p= $p")
end

figure(figsize=(5,5))
randomWalk(2501,0.5)
randomWalk(2501,0.51)
legend(loc="upper left")
savefig("randomWalks.png")

using Random, LinearAlgebra, PyPlot, PyCall
patch = pyimport("matplotlib.patches")
Random.seed!()

N = 10^5
data     = [[rand(),rand()] for _ in 1:N]
indata   = filter((x)-> (norm(x) <= 1), data)
outdata  = filter((x)-> (norm(x) > 1), data)
piApprox = 4*length(indata)/N
println("Pi Estimate: ", piApprox)

fig,ax = subplots(1,1,figsize=(5,5))
ax.plot(first.(indata),last.(indata),"b.",ms=0.2)
ax.plot(first.(outdata),last.(outdata),"r.",ms=0.2)
ax.set_aspect("equal")
r1 = patch.Wedge([0,0],1,0, 90,fc="none",ec="black")
ax.add_artist(r1)

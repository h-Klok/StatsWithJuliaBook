using Distributions, Plots; pyplot()

lambda, N = 1/3, 10^5
bulbs = [1,10,50]
xGrid = 0:0.1:10
C = [:blue :red :green]
dists = [Gamma(n,1/(n*lambda)) for n in bulbs]

function normalizedData(d::Gamma)
    sh = Int64(shape(d))
    data = [sum(-(1/(sh*lambda))*log.(rand(sh))) for _ in 1:N]
end

L = [ "Shape = "*string.(shape.(i))*", Scale = "*
    string.(round.(scale.(i),digits=2)) for i in dists ]

stephist( normalizedData.(dists), bins=50, 
    normed=:true, c=C, xlims=(0,maximum(xGrid)),ylims=(0,1), 
    xlabel="x", ylabel="Density", label="")
plot!(xGrid, [pdf.(i,xGrid) for i in dists], c=C, label=reshape(L, 1,:))
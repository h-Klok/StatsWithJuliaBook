using Random, Distributions, KernelDensity, Plots; pyplot()
Random.seed!(0)

mu1, sigma1 = 10, 5
mu2, sigma2 = 40, 12
dist1, dist2 = Normal(mu1,sigma1), Normal(mu2,sigma2)
p = 0.3
mixRv() = (rand() <= p) ? rand(dist1) : rand(dist2)
mixPDF(x) = p*pdf(dist1,x) + (1-p)*pdf(dist2,x)

n = 2000
data = [mixRv() for _ in 1:n]

kdeDist = kde(data)

xGrid = -20:0.1:80
pdfKDE = pdf(kdeDist,xGrid)

plot(xGrid, pdfKDE, c=:blue, label="KDE PDF")
stephist!(data, bins=50, c=:black, normed=:true, label="Histogram")
p1 = plot!(xGrid, mixPDF.(xGrid), c=:red, label="Underlying PDF",
    xlims=(-20,80), ylims=(0,0.035), legend=:topleft,
    xlabel="X", ylabel = "Density")

hVals = [0.5,2,10]
kdeS = [kde(data,bandwidth=h) for h in hVals]
plot(xGrid, pdf(kdeS[1],xGrid), c = :green, label= "h=$(hVals[1])")
plot!(xGrid, pdf(kdeS[2],xGrid), c = :blue, label= "h=$(hVals[2])")
p2 = plot!(xGrid, pdf(kdeS[3],xGrid), c = :purple, label= "h=$(hVals[3])",
    xlims=(-20,80), ylims=(0,0.035), legend=:topleft, 
    xlabel="X", ylabel = "Density")
plot(p1,p2,size = (800,400))
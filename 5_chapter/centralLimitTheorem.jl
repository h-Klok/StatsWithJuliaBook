using Distributions, Plots; pyplot()

n, N = 30, 10^6

dist1 = Uniform(1-sqrt(3),1+sqrt(3))
dist2 = Exponential(1)
dist3 = Normal(1,1)

data1 = [mean(rand(dist1,n)) for _ in 1:N]
data2 = [mean(rand(dist2,n)) for _ in 1:N]
data3 = [mean(rand(dist3,n)) for _ in 1:N]

stephist([data1 data2 data3], bins=100, 
    c=[:blue :red :green], xlabel = "x", ylabel = "Density",
    label=["Average of Uniforms" "Average of Exponentials" "Average of Normals"], 
    normed=true, xlims=(0,2), ylims=(0,2.5))
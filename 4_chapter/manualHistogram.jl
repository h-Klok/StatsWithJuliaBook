using Plots, Distributions, Random; pyplot()
Random.seed!(0)

n = 2000
data = rand(Normal(),n)
l, m = minimum(data), maximum(data)

delta = 0.3;
bins = [(x,x+delta) for x in l:delta:m-delta]
if last(bins)[2] < m 
    push!(bins,(last(bins)[2],m)) 
end
L = length(bins)

inBin(x,j) = first(bins[j]) <= x && x < last(bins[j])
sizeBin(j) = last(bins[j]) - first(bins[j])
f(j) = sum([inBin(x,j)  for x in data])/n
h(x) = sum([f(j)/sizeBin(j) * inBin(x,j) for j in 1:L])

xGrid = -4:0.01:4
histogram(data,normed=true, bins=L, 
    label="Built-in histogram",
    c=:blue, la=0, alpha=0.6)
plot!(xGrid,h.(xGrid), lw=3, c=:red, label="Manual histogram",
    xlabel="x",ylabel="Frequency")
plot!(xGrid,pdf.(Normal(),xGrid),label="True PDF", 
    lw=3, c=:green, xlims=(-4,4), ylims=(0,0.5))

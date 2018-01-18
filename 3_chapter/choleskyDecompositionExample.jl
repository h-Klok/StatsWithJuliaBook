using DataFrames, Distributions, PyPlot

data = readtable("BrisGCtemp.csv")
Bris = data[4]
GC = data[5]

temps = hcat(Bris, GC)

E = [temps[rand(1:4),:] for _ in 1:10^5]
F = vcat([e' for e in E]...)
cov(F)

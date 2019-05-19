using Distributions, LinearAlgebra, PyPlot

SigY = [ 6 4 ; 4 9]
muY = [15 ; 20]
A = cholesky(SigY).L

N = 10^5

dist_a = Normal()
rvX_a() = [rand(dist_a) ; rand(dist_a)]
rvY_a() = A*rvX_a() + muY
data_a = [rvY_a() for _ in 1:N]
data_a1 = first.(data_a)
data_a2 = last.(data_a)

dist_b = Uniform(-sqrt(3),sqrt(3))
rvX_b() = [rand(dist_b) ; rand(dist_b)]
rvY_b() = A*rvX_b() + muY
data_b = [rvY_b() for _ in 1:N]
data_b1 = first.(data_b)
data_b2 = last.(data_b)

dist_c = Exponential()
rvX_c() = [rand(dist_c) - 1; rand(dist_c) - 1]
rvY_c() = A*rvX_c() + muY
data_c = [rvY_c() for _ in 1:N]
data_c1 = first.(data_c)
data_c2 = last.(data_c)

plot(data_a1,data_a2,".",color="blue",ms=0.2)
plot(data_b1,data_b2,".",color="red",ms=0.2)
plot(data_c1,data_c2,".",color="green",ms=0.2)

stats(data1,data2) = println(
    round(mean(data1),digits=2), "\t", round(mean(data2),digits=2), "\t",
    round(var(data1),digits=2), "\t", round(var(data2),digits=2), "\t",
    round(cov(data1,data2),digits=2))

println("Mean1\tMean2\tVar1\tVar2\tCov")
stats(data_a1,data_a2)
stats(data_b1,data_b2)
stats(data_c1,data_c2)

using Distributions, Random, Plots, LaTeXStrings; pyplot()

N, K, M = 10^2, 50, 10^3
lamRange = 0.01:0.01:0.99

prn(lambda,rng) = quantile(Poisson(lambda),rand(rng))
zDist(lam) = Uniform(0,2*(1-lam))

rv(lam,rng) = sum([rand(rng,zDist(lam)) for _ in 1:prn(K*lam,rng)])
rv2(lam,rng1,rng2) = sum([rand(rng1,zDist(lam)) for _ in 1:prn(K*lam,rng2)])

mEst(lam,rng) = mean([rv(lam,rng) for _ in 1:N])
mEst2(lam,rng1,rng2) = mean([rv2(lam,rng1,rng2) for _ in 1:N])

function mGraph0(seed)
    singleRng = MersenneTwister(seed)
    [mEst(lam,singleRng) for lam in lamRange]
end
mGraph1(seed) = [mEst(lam,MersenneTwister(seed)) for lam in lamRange]
mGraph2(seed1,seed2) = [mEst2(lam,MersenneTwister(seed1),
		MersenneTwister(seed2)) for lam in lamRange]

argMaxLam(graph) = lamRange[findmax(graph)[2]]

std0 = std([argMaxLam(mGraph0(seed)) for seed in 1:M])
std1 = std([argMaxLam(mGraph1(seed)) for seed in 1:M])
std2 = std([argMaxLam(mGraph2(seed,seed+M)) for seed in 1:M])

println("Standard deviation with no CRN: ", std0)
println("Standard deviation with CRN and single RNG: ", std1)
println("Standard deviation with CRN and two RNGs: ", std2)

plot(lamRange,mGraph0(1987),
	c=:red, label="No CRN")
plot!(lamRange,mGraph1(1987),
	c=:green, label="CRN and one RNG")
plot!(lamRange,mGraph2(1987,1988),
	c=:blue, label="CRN and two RNG's", xlims=(0,1),ylims=(0,14),
    xlabel=L"\lambda", ylabel = "Mean")
using Distributions, Plots, LaTeXStrings; pyplot()

function statPair(dist,n)
    sample = rand(dist,n)
    [mean(sample),var(sample)]
end

stdUni = Uniform(-sqrt(3),sqrt(3))
n, N = 3, 10^5

dataUni     = [statPair(stdUni,n) for _ in 1:N]
dataUniInd  = [[mean(rand(stdUni,n)),var(rand(stdUni,n))] for _ in 1:N]
dataNorm    = [statPair(Normal(),n) for _ in 1:N]
dataNormInd = [[mean(rand(Normal(),n)),var(rand(Normal(),n))] for _ in 1:N]

p1 = scatter(first.(dataUni), last.(dataUni), 
	c=:blue, ms=1, msw=0, label="Same group")
p1 = scatter!(first.(dataUniInd), last.(dataUniInd), 
	c=:red, ms=0.8, msw=0, label="Separate group", 
	xlabel=L"\overline{X}", ylabel=L"S^2")

p2 = scatter(first.(dataNorm), last.(dataNorm), 
	c=:blue, ms=1, msw=0, label="Same group")
p2 = scatter!(first.(dataNormInd), last.(dataNormInd),
	c=:red, ms=0.8, msw=0, label="Separate group", 
	xlabel=L"\overline{X}", ylabel=L"$S^2$")

plot(p1, p2, ylims=(0,5), size=(800, 400))
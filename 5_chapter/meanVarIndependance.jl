using Distributions,PyPlot

function statPair(dist,n)
    sample = rand(dist,n)
    [mean(sample),var(sample)]
end

stdUni = Uniform(-sqrt(3),sqrt(3))
n, N = 2, 10^5

dataUni     = [statPair(stdUni,n) for _ in 1:N]
dataUniInd  = [[mean(rand(stdUni,n)),var(rand(stdUni,n))] for _ in 1:N]
dataNorm    = [statPair(Normal(),n) for _ in 1:N]
dataNormInd = [[mean(rand(Normal(),n)),var(rand(Normal(),n))] for _ in 1:N]

figure("test", figsize=(10,5))
subplot(121)
plot(first.(dataUni),last.(dataUni),".b",ms="0.1",label="Same group")
plot(first.(dataUniInd),last.(dataUniInd),".r",ms="0.1", label="Separate group")
xlabel(L"$\overline{X}$")
ylabel(L"$S^2$")
legend(markerscale=60,loc="upper right")
ylim(0,10)

subplot(122)
plot(first.(dataNorm),last.(dataNorm),".b",ms="0.1",label="Same group")
plot(first.(dataNormInd),last.(dataNormInd),".r",ms="0.1",label="Separate group")
xlabel(L"$\overline{X}$")
ylabel(L"$S^2$")
legend(markerscale=60,loc="upper right")
ylim(0,10)

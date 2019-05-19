using Random, Distributions, KernelDensity, PyPlot
Random.seed!(0)

mu1, sigma1 = 10, 5
mu2, sigma2 = 40, 12

z1 = Normal(mu1,sigma1)
z2 = Normal(mu2,sigma2)

p = 0.3

function mixRv()
    (rand() <= p) ? rand(z1) : rand(z2)
end

function actualPDF(x)
    p*pdf(z1,x) + (1-p)*pdf(z2,x)
end

numSamples = 100
data = [mixRv() for _ in 1:numSamples]

xGrid = -20:0.1:80
pdfActual = actualPDF.(xGrid)
kdeDist = kde(data)
pdfKDE = pdf(kdeDist,xGrid)

plt.hist(data,20, histtype = "step", normed=true, label="Sample data")
plot(xGrid,pdfActual,"-b",label="Underlying PDF")
plot(xGrid,pdfKDE, "-r",label="KDE PDF")
xlim(-20,80)
ylim(0,0.035)
xlabel(L"X")
legend(loc="upper right")

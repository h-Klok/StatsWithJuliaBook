using Distributions, PyPlot
srand(1)

sampleData = readcsv("machine1.csv")[:,1]
n, N = length(sampleData), 10^6
alpha = 0.1

bootstrapSampleMeans = [mean(rand(sampleData, n)) for i in 1:N]
L = quantile(bootstrapSampleMeans, alpha/2)
U = quantile(bootstrapSampleMeans, 1-alpha/2)

plt[:hist](bootstrapSampleMeans, 100, normed=true, histtype = "step")
plot([L,L],[0,0.2],"r")
plot([U,U],[0,0.2],"r")
annotate("Lower CI", xy=(L,0.2))
annotate("Upper CI", xy=(U,0.2))
savefig("bCI.pdf");

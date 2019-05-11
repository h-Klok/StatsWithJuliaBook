using Distributions, PyPlot

n, N = 20, 10^7

dist1 = Uniform(1-sqrt(3),1+sqrt(3))
dist2 = Exponential(1)
dist3 = Normal(1,1)

data1 = [mean(rand(dist1,n)) for _ in 1:N]
data2 = [mean(rand(dist2,n)) for _ in 1:N]
data3 = [mean(rand(dist3,n)) for _ in 1:N]

plt.hist(data1,200,color="b",label="Uniform",histtype="step",normed="True")
plt.hist(data2,200,color="r",label="Exponential",histtype="step",normed="True")
plt.hist(data3,200,color="g",label="Normal",histtype="step",normed="True")
xlim(0,2)
legend(loc="upper right")

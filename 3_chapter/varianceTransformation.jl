using Distributions,PyPlot
dist = TriangularDist(4,6,5)
N = 10^6
data = rand(dist,N)
yData=(data.-5).^2

figure(figsize=(10,5))
subplots_adjust(wspace=0.4)

subplot(121)
plt.hist(data,100, normed="true")
xlabel("x")
ylabel("Proportion")

subplot(122)
plt.hist(yData,100, normed="true")
xlabel("y")
ylabel("Proportion")

mean(yData),var(data)

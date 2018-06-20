using Distributions, PyPlot
srand(1)

n = 100
dataA = rand(Normal(15,2),n)
dataB = rand(Normal(16,2),n)

grid = 5:0.1:25

truePositive = [count(i->(i<=x),dataA)/n for x in grid]
falsePositive = [count(i->(i<=x),dataB)/n for x in grid]

figure("test",figsize=(4,4))
subplot(111)
plot([0,1],[0,1],ls="--")
plot(falsePositive,truePositive);
savefig("roc3.png")

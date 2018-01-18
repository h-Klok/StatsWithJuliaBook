using PyPlot

n = 10^5

u = -pi/2+rand(n)*pi
data = tan.(u)
runningMean = [mean(data[1:i]) for i in 1:n]

plot(1:n,runningMean);

#####
using Distributions, PyPlot
function cauchyRunningAverage(n::Int)
      a = 0
      y = fill(NaN,n)
      for i in 1:n
          a += rand(Cauchy())
          y[i] = a/i
      end
      return y
end

xGrid(n::Int) = collect(1:n)

runs = 10^6
plot(xGrid(runs),cauchyRunningAverage(runs))
savefig("cauchyRunningAverage.png")

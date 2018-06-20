# there is also a moment function
using Distributions, PyPlot 
srand(1)

n = 20
dist = TriangularDist(3,5,4)
samples = rand(dist,20)

m_k(k,data) = 1/n*sum(data.^k)

mHats =[m_k(i,samples) for i in 1:3]

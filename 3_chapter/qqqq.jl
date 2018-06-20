using Distributions, PyPlot

# want two data series, with means and std below
mu1, sig1 = 25, 5
mu2, sig2 = 30, 8

# First generate 2 uncorrelated random variables
N = 10^6
data1 = rand(Normal(mu1,sig1),N)
data2 = rand(Normal(mu2,sig2),N);

# Note, covariance matrix different from correlation matrix!
# let us imagine we want a correlation of 0.99
corr = 0.99

Mu = [mu1;mu2]

sigma = [var(data1) cov(data1,data2);
        cov(data1,data2) var(data2)]

Y = Mu .+ Array(cholfact(sigma)[:U])*[data1 data2]'
Y = transpose(Y)

plot(Y[:,1],Y[:,2],".")

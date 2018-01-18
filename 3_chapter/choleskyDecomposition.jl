### Question....why do we actually use this? we need 'sig' already to perform Cholesky on...why not just sample from X directly???
using Distributions
srand(1)

m = 10^6

x = Normal(2,1.2)
y = Normal()
z = Normal(1,0.8)

dists = [x,y,z]
n = length(dists)

mu = mean.(dists) 

corM = [1 0.8 -0.5; 
       0.8 1 -0.1;
       -0.5 -0.1 1]

sig = corM .* [ std(dists[i])*std(dists[j]) for i in 1:n, j in 1:n ]
    
X = MvNormal(mu, sig)

data2 = rand(X,m)

means2 = [mean(data2[i,:]) for i in 1:n]

stdDev2 = [std(data2[i,:]) for i in 1:n]

corr2 = [cor(data2[1,:],data2[2,:]);
       cor(data2[1,:],data2[3,:]);
       cor(data2[2,:],data2[3,:])]

println("Means: ", means2)
println("StdDev: ", stdDev2)
println("Correlations: ", corr2)

########################################################################
# Julia has an inbuilt cholesky decomposition function in base
A = chol(sig)' # need ' to get LT

data = mu .+  A * rand(MvNormal(3, 1),m)#NB: MvNorm is iid std norm in R3

# Now check mean, std, and cor
means = [mean(data[i,:]) for i in 1:n]

stdDev = [std(data[i,:]) for i in 1:n]

corr = [cor(data[1,:],data[2,:]);
       cor(data[1,:],data[3,:]);
       cor(data[2,:],data[3,:])]

println("Means: ", means)
println("StdDev: ", stdDev)
println("Correlations: ", corr)

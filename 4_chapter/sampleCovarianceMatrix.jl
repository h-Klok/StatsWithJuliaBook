using Statistics

X = [0.9 2.1 1.2;
     1.1 1.9 2.5;
     1.7 1.9 3.4;
     0.8 2.3 2.3;
     1.3 1.6 9.4;
     0.7 2.7 1.3;
     0.9 2.1 4.4]

n,p = size(X)

xbar = [mean(X[:,i]) for i in 1:p]'
ourCov = (X .- xbar)'*(X .- xbar)/(n-1)

println(ourCov)
println(cov(X))

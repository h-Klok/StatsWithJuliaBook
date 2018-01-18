X = [0.9 2.1;
    1.01   1.95;
    1.03    1.92;
    0.84     2.3;
    1.2      1.86;
    0.76      2.17;
    0.98     2.01]

n,p = size(X)

muTemp = [mean(X[:,i]) for i in 1:p]
mu = [muTemp[1] muTemp[2]]  #QQQQQ

ourCov = (X .- mu)'*(X .- mu)/(n-1)

println(ourCov) #QQQQ - Hayden how to output

println([var(X[:,k]) for k in 1:p])

println(cov(X))

X1 = X[:,1]
X2 = X[:,2]
ourCov12 = sum((X1-mu[1]).*(X2-mu[2]))/(n-1)  #Hayden how to do inner product QQQQ

println(ourCov12)

println(cov(X1,X2))

cor(X1,X2) , cov(X1,X2)/sqrt(var(X1)*var(X2)) , cov(X1,X2)/(std(X1)*std(X2))

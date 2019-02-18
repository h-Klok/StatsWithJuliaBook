using Distributions, GLM, DataFrames, PyPlot, Random, LinearAlgebra
Random.seed!(1)

n = 1000
beta0, beta1, beta2 = 20, 5, 7
sig = 2.5

x1 = collect(1:n) + 0.2*rand(Normal(),n)
x2 = collect(1:n) + 0.2*rand(Normal(),n)
x3 = x1 + 2*x2 + 0.1*rand(Normal(),n)
y = beta0 .+ beta1*x1 + beta2*x2 + rand(Normal(),n)

df = DataFrame(Y = y, X1 = x1, X2 = x2, X3 = x3)

model = lm(@formula(Y ~ X1 + X2 + X3),df)

A = [ones(n) x1 x2 x3]
psInv(lambda) = inv(A'*A+lambda*Matrix{Float64}(I, 4, 4))*A' 
coefManual = psInv(0.1)*y
coefGLM = coef(model)

coefManual,coefGLM
using Distributions, GLM, DataFrames, Random, LinearAlgebra
Random.seed!(0)

n = 100
beta0, beta1, beta2, beta3 = 10, 30, 60, 90
sig, sigX = 25, 5
etaVals = [200.0, 100.0 , 50.0, 10.0, 1.0, 0.1, 0.01, 0.0]

function createDataFrame(eta)
    Random.seed!(1)
    x1 = round.(collect(1:n) + sigX*rand(Normal(),n),digits = 5)
    x2 = round.(collect(1:n) + sigX*rand(Normal(),n),digits = 5)
    x3 = round.(x1 +2*x2 + eta*rand(Normal(),n),digits = 5)
    y = beta0 .+ beta1*x1 + beta2*x2 + beta3*x3 + sig*rand(Normal(),n)
    return DataFrame(Y = y, X1 = x1, X2 = x2, X3 = x3)
end

VIF3() = 1/(1-r2(lm(@formula(X3 ~ X1 + X2),df)))

for eta in etaVals
    print("eta = $(eta): ")
    df = createDataFrame(eta)
    glmOK = true
    try
        global model = lm(@formula(Y ~ X1 + X2 + X3),df)
    catch err
        println("Exception with GLM: ", err)
        glmOK = false
    end

    if glmOK
        covMat = vcov(model)
        sigVec = sqrt.(diag(covMat))
        corrmat = round.(covMat ./ (sigVec*sigVec'),digits=5)
        println("Corr(X1,X3) = ", corrmat[2,4],
                ",\t Corr(X2,X3) = ",corrmat[3,4],
                ",\t VIF3 = ", round.(VIF3(),digits=2) )
    else
         println("\t In this case we may use SVD or ridge regression if needed.")
    end
end
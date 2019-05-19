using Distributions, GLM, DataFrames, PyPlot, Random, LinearAlgebra

n = 100
beta0, beta1, beta2, beta3 = 10, 30, 60, 90
sig = 25
sigX = 5
etaVals = [50.0, 10.0, 1.0, 0.1, 0.001, 0.0]

function createDataFrame(eta)
    Random.seed!(1)
    x1 = round.(collect(1:n) + sigX*rand(Normal(),n),digits = 5)
    x2 = round.(collect(1:n) + sigX*rand(Normal(),n),digits = 5)
    x3 = round.(x1 +2*x2 + eta*rand(Normal(),n),digits = 5)
    y = beta0 .+ beta1*x1 + beta2*x2 + beta3*x3 + sig*rand(Normal(),n)
    return DataFrame(Y = y, X1 = x1, X2 = x2, X3 = x3)
end

for eta in etaVals
    println("\n **** eta = $(eta):")
    df = createDataFrame(eta)
    glmOK = true
    try
        global model = lm(@formula(Y ~ X1 + X2 + X3),df)
    catch err
        println("\nException with GLM: ", err, "!!!!\n\n")
        glmOK = false
    end

    if glmOK
        covMat = vcov(model)
        sigVec = sqrt.(diag(covMat))
        corrmat = round.(covMat ./ (sigVec*sigVec'),digits=6)
        println("Cov(X1,X3) = ", corrmat[2,4],",\t Cov(X2,X3) = ",corrmat[3,4])
        println(model)
    else
        A = [ones(n) df.X1 df.X2 df.X3]
        psInv(lambda) = inv(A'*A + lambda*I)*A'
        for lam in [1000, 1, 0.5, 0.1, 0.01, 0.001, 0.0001, 0.0]
            println("lam = ",lam,
            	"\t coeff:",psInv(lam)*df.Y,
		"\t pInv diff: ",round(norm(psInv(lam)-pinv(A)),digits=6))
        end
    end
end

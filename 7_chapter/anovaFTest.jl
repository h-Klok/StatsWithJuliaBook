using GLM, Distributions, DataFrames, CategoricalArrays

data1 = parse.(Float64, readlines("../data/machine1.csv"))
data2 = parse.(Float64, readlines("../data/machine2.csv"))
data3 = parse.(Float64, readlines("../data/machine3.csv"))
allData = [data1, data2, data3]

function manualANOVA(allData)
    nArray = length.(allData)
    d = length(nArray)

    xBarTotal = mean(vcat(allData...))
    xBarArray = mean.(allData)

    ssBetween = sum( [nArray[i]*(xBarArray[i] - xBarTotal)^2 for i in 1:d] )
    ssWithin = sum([sum([(ob - xBarArray[i])^2 for ob in allData[i]])
				for i in 1:d])
    dfBetween = d-1
    dfError = sum(nArray)-d

    msBetween = ssBetween/dfBetween
    msError = ssWithin/dfError
    fStat = msBetween/msError
    pval = ccdf(FDist(dfBetween,dfError),fStat)
    return (fStat,pval)
end

function glmANOVA(allData)
    nArray = length.(allData)
    d = length(nArray)

    treatment = vcat([fill(k,nArray[k]) for k in 1:d]...)
    response = vcat(allData...)
    dataFrame = DataFrame(Response=response, Treatment=categorical(treatment))
    modelH0  = lm(@formula(Response ~ 1), dataFrame)
    modelH1a = lm(@formula(Response ~ 1 + Treatment), dataFrame)
    res = ftest(modelH1a.model, modelH0.model)
    return (res.fstat[2],res.pval[2]) 
end

println("Manual ANOVA: ", manualANOVA(allData))
println("GLM ANOVA: ", glmANOVA(allData))

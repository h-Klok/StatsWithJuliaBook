using GLM, DataFrames, Distributions

data1 = CSV.read("machine1.csv", header=false, allowmissing=:none)[:,1]
data2 = CSV.read("machine2.csv", header=false, allowmissing=:none)[:,1]
data3 = CSV.read("machine3.csv", header=false, allowmissing=:none)[:,1]

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
    dataFrame = DataFrame(Response = response, Treatment = treatment)
    dataFrame[:Treatment] = CategoricalArray(dataFrame[:Treatment])
    modelH0  = lm(@formula(Response ~ 1), dataFrame)
    modelH1a = lm(@formula(Response ~ 1 + Treatment), dataFrame)
    res = ftest(modelH1a.model, modelH0.model)
    (res.fstat[1],res.pval[1])
end

println("Manual ANOVA: ", manualANOVA([data1, data2, data3]))
println("GLM ANOVA: ", glmANOVA([data1, data2, data3]))
using StatsModels, RDatasets, DataFrames, GLM, Random
Random.seed!(0)

n = 30
df = dataset("MASS", "cpus")[1:n,:]
df.Freq = map( x->10^9/x , df.CycT)
df = df[:, [:Perf, :MMax, :Cach, :ChMax, :Freq]]
df.Junk1 = rand(n)
df.Junk2 = rand(n)

function stepReg(df, reVar, pThresh)
    predVars = setdiff(propertynames(df), [reVar])
    numVars = length(predVars)
    model = nothing
    while numVars > 0
        fm = term(reVar) ~ term.((1, predVars...))
        model = lm(fm, df)
        pVals = coeftable(model).cols[4][2:end]
        println("Variables: ", predVars)
        println("P-values = ", round.(pVals,digits = 3))
        pVal, knockout = findmax(pVals)
        pVal < pThresh && break
        println("\tRemoving the variable ", predVars[knockout], 
                " with p-value = ", round(pVal,digits=3))
        deleteat!(predVars,knockout)
        numVars = length(predVars)
    end
    model
end

model = stepReg(df, :Perf, 0.05)
println(model)
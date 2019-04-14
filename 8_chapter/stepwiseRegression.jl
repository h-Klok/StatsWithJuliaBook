using RDatasets, GLM, PyPlot

df = dataset("MASS", "cpus")
df.Freq = map( x->10^9/x , df.CycT)
df = df[:, [:Perf, :MMax, :Cach, :ChMax, :Freq]]

function stepReg(df, reVar, pThresh)
    predVars = setdiff(names(df), [reVar])
    fm = Formula(reVar, Expr(:call, :+, predVars...) )
    model = lm( fm, df)
    pVals = [p.v for p in coeftable(model).cols[4]]

    while maximum(pVals) > pThresh
        deleteat!(predVars, findmax(pVals)[2]-1 )
        fm = Formula(reVar, Expr(:call, :+, predVars...) )
        model = lm( fm, df)
        pVals = [p.v for p in coeftable(model).cols[4] ]
    end
    model
end

model = stepReg(df,:Perf, 0.05)
println(model)
println("Estimated performance for a specific computer (after model reduction):",
		coef(model)'*[1, 32000, 32, 32])

using RDatasets, GLM, Statistics

df = dataset("MASS", "cpus")
df.Freq = map( x->10^9/x , df.CycT)

model = lm(@formula(Perf ~ MMax + Cach + ChMax + Freq), df)
pred(x) = round(coef(model)'*vcat(1,x),digits = 3)

println("n = ", size(df)[1])
println("(Avg,Std) of observed performance: ", (mean(df.Perf),std(df.Perf)))
println(model)
println("Estimated performance for computer A: ", pred([32000, 32, 32, 4*10^7]))
println("Estimated performance for computer B: ", pred([32000, 16, 32, 6*10^7]))
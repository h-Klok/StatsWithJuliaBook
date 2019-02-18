using RDatasets, GLM

df = dataset("MASS", "cpus")
df[:Freq] = map( x->10^9/x , df[:CycT])

model = lm(@formula(Perf ~ MMax + Cach + ChMax + Freq), df)

println(model)
println("Estimated performance for a specific computer: ", 
		coef(model)'*[1, 32000, 32, 32, 4*10^7])
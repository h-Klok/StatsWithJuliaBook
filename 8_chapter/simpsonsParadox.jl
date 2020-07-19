using CSV, GLM, Plots; pyplot() 

df = CSV.read("../data/IQalc.csv")
groupA = df[df.Group .== "A", :]
groupB = df[df.Group .== "B", :]
groupC = df[df.Group .== "C", :]

model  = fit(LinearModel, @formula(AlcConsumption ~ IQ), df)
modelA = fit(LinearModel, @formula(AlcConsumption ~ IQ), groupA)
modelB = fit(LinearModel, @formula(AlcConsumption ~ IQ), groupB)
modelC = fit(LinearModel, @formula(AlcConsumption ~ IQ), groupC)

pred(x)  = coef(model)'  * [1, x]
predA(x) = coef(modelA)' * [1, x]
predB(x) = coef(modelB)' * [1, x]
predC(x) = coef(modelC)' * [1, x]

xlims = collect(extrema(df.IQ))

p1 = scatter(df.IQ, df.AlcConsumption, c=:black, msw=0, ma=0.2, label="")
     plot!(xlims, pred.(xlims), c=:black, label="All data")

p2 = scatter(groupA.IQ, groupA.AlcConsumption, c=:blue, msw=0, ma=0.2, label="")
     scatter!(groupB.IQ, groupB.AlcConsumption, c=:red, msw=0, ma=0.2, label="")
     scatter!(groupC.IQ, groupC.AlcConsumption, c=:green,msw=0, ma=0.2, label="")
     plot!(xlims, predA.(xlims), c=:blue, label="Group A")
     plot!(xlims, predB.(xlims), c=:red, label="Group B")
     plot!(xlims, predC.(xlims), c=:green, label="Group C")

plot(p1, p2, xlims=(xlims), ylims=(0,1), 
	xlabel="IQ", ylabel="Alcohol Metric", size=(800,400))
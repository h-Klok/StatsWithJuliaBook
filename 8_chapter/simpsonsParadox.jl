using DataFrames, GLM, PyPlot, CSV

df = CSV.read("IQalc.csv")
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

fig = figure(figsize=(10, 5))
subplot(121)
plot(df.IQ, df.AlcConsumption, "b.", alpha=0.1)
plot(xlims, pred.(xlims), "b", label="All data")
xlim(xlims), ylim(0,1)
xlabel("IQ")
ylabel("Alcohol metric")
legend(loc="upper right")

subplot(122)
plot(groupA.IQ, groupA.AlcConsumption, "b.", alpha=0.1)
plot(groupB.IQ, groupB.AlcConsumption, "r.", alpha=0.1)
plot(groupC.IQ, groupC.AlcConsumption, "g.", alpha=0.1)
plot(xlims, predA.(xlims), "b", label="Group A")
plot(xlims, predB.(xlims), "r", label="Group B")
plot(xlims, predC.(xlims), "g", label="Group C")
xlim(xlims), ylim(0,1)
xlabel("IQ")
ylabel("Alcohol metric")
legend(loc="upper right")

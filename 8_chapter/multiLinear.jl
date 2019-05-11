using CSV, RDatasets, DataFrames, GLM, PyPlot

df = CSV.read("weightHeight.csv")
mW = df[df.Sex .== "M", :Weight]
mH = df[df.Sex .== "M", :Height]
fW = df[df.Sex .== "F", :Weight]
fH = df[df.Sex .== "F", :Height]
categorical!(df, :Sex)
model = lm(@formula(Height ~ Weight + Sex), df)

predFemale(x) = coef(model)[1:2]'*[1, x]
predMale(x)   = [sum(coef(model)[[1,3]]) coef(model)[2]]*[1, x]

xlims = [minimum(df.Weight), maximum(df.Weight])

plot(mW, mH, "b.", label="Males")
plot(xlims, predMale.(xlims),"b", label="Male model")

plot(fW, fH, "r.", label="Females")
plot(xlims, predFemale.(xlims),"r", label="Female model")
xlim(xlims)
legend(loc="upper left")
println(model)

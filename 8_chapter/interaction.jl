using CSV, GLM, Plots; pyplot()

df = CSV.read("../data/weightHeight.csv")
mW = df[df.Sex .== "M", :Weight]
mH = df[df.Sex .== "M", :Height]
fW = df[df.Sex .== "F", :Weight]
fH = df[df.Sex .== "F", :Height]

model = lm(@formula(Height ~ Weight * Sex), df)
predFemale(x) = coef(model)[1:2]'*[1, x]
predMale(x)   = sum([sum(coef(model)[[1,3]]), sum(coef(model)[[2,4]])] .* [1, x])

println(model)

xlim = [minimum(df.Weight), maximum(df.Weight)]
scatter(mW, mH, c=:blue, msw=0, label="Males")
plot!(xlim, predMale.(xlim), c=:blue, label="Male model")

scatter!(fW, fH, c=:red, msw=0, label="Females")
plot!(xlim, predFemale.(xlim),
	c=:red, label="Female model", xlims=(xlim),
	xlabel="Weight (kg)", ylabel="Height (cm)", legend=:topleft)
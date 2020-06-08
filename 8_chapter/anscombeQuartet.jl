using RDatasets, DataFrames, GLM, Plots, Measures; pyplot()

df = dataset("datasets", "anscombe")

model1 = lm(@formula(Y1 ~ X1), df)
model2 = lm(@formula(Y2 ~ X2), df)
model3 = lm(@formula(Y3 ~ X3), df)
model4 = lm(@formula(Y4 ~ X4), df)

println("Model 1. Coefficients: ", coef(model1),"\t R squared: ",r2(model1))
println("Model 2. Coefficients: ", coef(model2),"\t R squared: ",r2(model2))
println("Model 3. Coefficients: ", coef(model3),"\t R squared: ",r2(model3))
println("Model 4. Coefficients: ", coef(model4),"\t R squared: ",r2(model4))

yHat(model, X) = coef(model)' * [ 1 , X ]
xlims = [0, 20]

p1 = scatter(df.X1, df.Y1, c=:blue, msw=0, ms=8)
p1 = plot!(xlims, [yHat(model1, x) for x in xlims], c=:red, xlims=(xlims))

p2 = scatter(df.X2, df.Y2, c=:blue, msw=0, ms=8)
p2 = plot!(xlims, [yHat(model2, x) for x in xlims], c=:red, xlims=(xlims))

p3 = scatter(df.X3, df.Y3, c=:blue, msw=0, ms=8)
p3 = plot!(xlims, [yHat(model3, x) for x in xlims], c=:red, xlims=(xlims))

p4 = scatter(df.X4, df.Y4, c=:blue, msw=0, ms=8)
p4 = plot!(xlims, [yHat(model4, x) for x in xlims], c=:red, msw=0, xlims=(xlims))

plot(p1, p2, p3, p4, layout = (2,2), xlims=(0,20), ylims=(0,14), 
	legend=:none, xlabel = "x", ylabel = "y",
    	size=(1200, 800), margin = 10mm)
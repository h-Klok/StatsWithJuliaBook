using RDatasets, DataFrames, GLM, PyPlot

df = dataset("datasets", "Anscombe")

model1 = lm(@formula(Y1 ~ X1), df)
model2 = lm(@formula(Y2 ~ X2), df)
model3 = lm(@formula(Y3 ~ X3), df)
model4 = lm(@formula(Y4 ~ X4), df)

yHat(model, X) = coef(model)' * [ 1 , X ]
xlims = [0, 20]

subplot(221)
plot(df.X1, df.Y1,".b")
plot(xlims, [yHat(model1, i) for i in xlims], "r")
xlim(xlims)

subplot(222)
plot(df.X2, df.Y2,".b")
plot(xlims, [yHat(model2, i) for i in xlims], "r")
xlim(xlims)

subplot(223)
plot(df.X3, df.Y3,".b")
plot(xlims, [yHat(model3, i) for i in xlims], "r")
xlim(xlims)

subplot(224)
plot(df.X4, df.Y4,".b")
plot(xlims, [yHat(model4, i) for i in xlims], "r")
xlim(xlims)

println("Model 1. Coefficients: ", coef(model1),"\t R squared: ",r2(model1))
println("Model 2. Coefficients: ", coef(model2),"\t R squared: ",r2(model2))
println("Model 3. Coefficients: ", coef(model3),"\t R squared: ",r2(model3))
println("Model 4. Coefficients: ", coef(model4),"\t R squared: ",r2(model4))

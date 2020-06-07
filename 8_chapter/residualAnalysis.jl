using CSV, GLM, Distributions, StatsPlots, Plots, Measures; pyplot()

df = CSV.read("../data/weightHeight.csv")

model = lm(@formula(Height ~ Weight), df)
pred(x) = coef(model)'*[1, x]
residuals = df.Height - pred.(df.Weight)

p1 = plot([minimum(df.Weight),maximum(df.Weight)],[0,0], lw = 2, c=:black)
scatter!(df.Weight, residuals, xlabel = "Weight (kg)", ylabel = "Residual (cm)",
    c=:blue, msw=0, legend = false)

p2 = qqnorm(residuals, msw=0, lw=2, c =[:red :blue],legend = false,
        xlabel="Normal Theoretical Quantiles",
        ylabel="Residual Quantiles")

plot(p1,p2,size=(1000,500),margin = 5mm)
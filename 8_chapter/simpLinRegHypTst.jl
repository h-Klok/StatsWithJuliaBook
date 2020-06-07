using CSV, GLM, Distributions, Plots; pyplot()

data = CSV.read("../data/weightHeight.csv")
df = sort(data, :Weight)[1:20,:]
model = lm(@formula(Height ~ Weight), df)
pred(x) = coef(model)'*[1, x]
tStat = coef(model)[2]/stderror(model)[2]
n = size(df)[1]
pVal = 2*ccdf(TDist(n-2),tStat)
println("Manual Pval: ", pVal)
println("Manual Confidence Interval: ", 
    (coef(model)[2] - quantile(TDist(n-2), 0.975)*stderror(model)[2],
     coef(model)[2] + quantile(TDist(n-2), 0.975)*stderror(model)[2]))
println(model)

scatter(df.Weight, df.Height,c=:blue, msw=0)
xlims = [minimum(df.Weight), maximum(df.Weight)]
plot!(xlims, pred.(xlims), 
    c=:red, legend=:none, xlabel = "Weight (kg)", ylabel = "Height (cm)")
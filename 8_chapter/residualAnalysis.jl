using CSV, GLM, LinearAlgebra, StatsPlots, Plots, Measures; pyplot()

df = CSV.read("../data/weightHeight.csv")
n = size(df)[1]

model = lm(@formula(Height ~ Weight), df)
MSE = deviance(model)/dof_residual(model)
pred(x) = coef(model)'*[1, x]

A = [ones(n) df.Weight]
H = A*pinv(A)
residuals = (I-H)*df.Height
studentizedResiduals = residuals ./ (sqrt.(MSE*(1 .- diag(H))))

tau = rank(H)
println("tau = ", tau, " or ", sum(diag(H)), " or ", tr(H))

cookDistances = (studentizedResiduals.^2/tau) .* diag(H) ./ (1 .- diag(H))
maxCook, indexMaxCook = findmax(cookDistances)
println("Maximal Cook's distance = ", maxCook)

p1 = plot([minimum(df.Weight),maximum(df.Weight)],[0,0],
		lw = 2, c=:black, label=:none)
     scatter!([df.Weight[indexMaxCook]],[studentizedResiduals[indexMaxCook]], 
                c=:red, ms = 10, msw = 0, shape =:cross, 
                label = "Point with maximal Cook's distance",legend=:topleft)

    scatter!(df.Weight, studentizedResiduals, xlabel = "Weight (kg)",
             ylabel = "Studentized Residual (cm)",c=:blue,msw=0,label=:none)

p2 = qqnorm(studentizedResiduals, msw=0, lw=2, c =[:red :blue],legend = false,
        xlabel="Normal Theoretical Quantiles",
        ylabel="Studentized Residual Quantiles")

plot(p1,p2,size=(1000,500),margin = 5mm)
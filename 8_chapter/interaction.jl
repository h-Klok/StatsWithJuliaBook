using CSV, GLM, Plots, Random; pyplot()
Random.seed!(0)

df = CSV.read("../data/weightHeight.csv", copycols = true)
n = size(df)[1]
df[shuffle(1:n),:] = df
df[[10,40,60,130,140,175,190,200],:Sex] .= "O"

conts = Dict(:Sex=>DummyCoding(base="F",levels=["F","M","O"]))
model1 = lm(@formula(Height ~ Weight * Sex), df, contrasts=conts)
model2 = lm(@formula(Height ~ Weight & Sex), df, contrasts=conts)
model3 = lm(@formula(Height ~ Weight + Weight & Sex), df, contrasts=conts)

a0, a1, a2, a3, a4, a5 = coef(model1)
b0, b1, b2, b3 = coef(model2)
c0, c1, c2, c3 = coef(model3)

println(model1) 
println(model2) 
println(model3)
println("Model2 and Model3 equivalence: ", 
    round.((b0 - c0, b1 - c1, b2 - (c1+c2), b3 - (c1+c3)),digits=5))

pred1(weight,sex) =  a0 + a1 * weight + 
				(sex=="M")*(a2+a4*weight)+
				(sex=="O")*(a3+a5*weight)
pred2(weight,sex) =  b0 + weight*(b1*(sex=="F") + b2*(sex=="M") + b3*(sex=="O"))

males,females,other=df[df.Sex .=="M",:],df[df.Sex .=="F",:],df[df.Sex .=="O",:]

xlim = [0, maximum(df.Weight)]
scatter(males.Weight, males.Height, c=:blue, msw=0, label="Male")
plot!(xlim, pred1.(xlim,"M"), c=:blue, lw = 1.5, label="Male fit 1")
plot!(xlim, pred2.(xlim,"M"), c=:blue, linestyle=:dash, label="Male fit 2")
scatter!(females.Weight, females.Height, c=:red, msw=0, label="Female")
plot!(xlim, pred1.(xlim,"F"), c=:red, lw=1.5,label="Female fit 1",xlims=(xlim))
plot!(xlim, pred2.(xlim,"F"), c=:red, linestyle=:dash, label="Female fit 2")
scatter!(other.Weight, other.Height, c=:green, msw=0, label="Other",
	xlabel="Weight (kg)", ylabel="Height (cm)", legend=:topleft)
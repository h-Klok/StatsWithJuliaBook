using CSV, GLM, Plots, Random; pyplot()
Random.seed!(0)

df = CSV.read("../data/weightHeight.csv", copycols = true)
n = size(df)[1]
df[shuffle(1:n),:] = df
df[[10,40,60,130,140,175,190,200],:Sex] .= "O"

conts = Dict(:Sex=>DummyCoding(base="F",levels=["F","M","O"]))

model1 = lm(@formula(Height ~ Weight * Sex), df, contrasts=conts)
model2 = lm(@formula(Height ~ Weight + Weight & Sex), df, contrasts=conts)
model3 = lm(@formula(Height ~ Weight & Sex), df, contrasts=conts)
println(model1); println(model2); println(model3)

b0, b1, b2, b3 = coef(model3)
pred(weight,sex) =  b0 + weight*(b1*(sex=="F") + b2*(sex=="M") + b3*(sex=="O"))

males,females,other=df[df.Sex .=="M",:],df[df.Sex .=="F",:],df[df.Sex .=="O",:]

xlim = [minimum(df.Weight), maximum(df.Weight)]
scatter(males.Weight, males.Height, c=:blue, msw=0, label="Male")
plot!(xlim, pred.(xlim,"M"), c=:blue, label="Male fit")
scatter!(females.Weight, females.Height, c=:red, msw=0, label="Female")
plot!(xlim, pred.(xlim,"F"), 
	c=:red, label="Female fit", xlims=(xlim), 
	xlabel="Weight (kg)", ylabel="Height (cm)", legend=:topleft)
scatter!(other.Weight, other.Height, c=:green, msw=0, label="Other")
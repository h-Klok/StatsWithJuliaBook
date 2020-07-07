using CSV, GLM, Plots, Random; pyplot()
Random.seed!(0)

df = CSV.read("../data/weightHeight.csv", copycols = true)
n = size(df)[1]
df[shuffle(1:n),:] = df
df[[10,40,60,130,140,175,190,200],:Sex] .= "O"

model = lm(@formula(Height ~ Weight * Sex), df,
        contrasts=Dict(:Sex=>DummyCoding(base="F",levels=["F","M","O"])))
b0, b1, b2, b3, b4, b5  = coef(model)
pred(weight,sex) =  b0 + b1*weight + 
                    b2*(sex=="M") + b3*(sex=="O") + 
                    b4*weight*(sex=="M") + b5*weight*(sex=="O")
println(model)

males = df[df.Sex .== "M",:]
females = df[df.Sex .== "F",:]
other = df[df.Sex .== "O",:]

xlim = [minimum(df.Weight), maximum(df.Weight)]
scatter(males.Weight, males.Height, c=:blue, msw=0, label="Male")
plot!(xlim, pred.(xlim,"M"), c=:blue, label="Male fit")
scatter!(females.Weight, females.Height, c=:red, msw=0, label="Female")
plot!(xlim, pred.(xlim,"F"), 
	c=:red, label="Female fit", xlims=(xlim), 
	xlabel="Weight (kg)", ylabel="Height (cm)", legend=:topleft)
scatter!(other.Weight, other.Height, c=:green, msw=0, label="Other")
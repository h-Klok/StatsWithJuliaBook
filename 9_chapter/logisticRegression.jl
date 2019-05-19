using GLM, DataFrames, Distributions, PyPlot, CSV

data = CSV.read("examData.csv")

model = glm(@formula(Pass ~ Hours), data, Binomial(), LogitLink())

pred(x) = 1/(1+exp(-(coef(model)[1] + coef(model)[2]*x)))

xGrid = 0:0.1:maximum(data.Hours)

plot(data.Hours, data.Pass, "b.")
plot(xGrid, pred.(xGrid), "r")
xlabel("Hours studied")
xlim(0, maximum(data.Hours))
yticks([0,1], ["0 (Fail)", "1 (Pass)"])

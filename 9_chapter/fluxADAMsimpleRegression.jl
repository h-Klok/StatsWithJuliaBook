cd(@__DIR__)
using Flux, Random, LinearAlgebra, CSV
using Flux.Optimise: update!
data = CSV.read("../data/L1L2data.csv")
xVals, yVals = Array{Float64}(data.X), Array{Float64}(data.Y)

Random.seed!(0)
b = rand(2)
predict(x) = b[1] .+ b[2]*x
loss(x,y) = sum((y .- predict(x)).^2)
opt = ADAM(0.01)
bPrev = -b
iter = 0
lossTrace = []
bTrace = []
#while norm(bPrev-b) > 10^-2
for _ in 1:1000
    bPrev = copy(b)
    gs = gradient(()->loss(xVals,yVals),params(b))
    update!(opt,b,gs[b])
    global iter += 1
    push!(lossTrace,loss(xVals,yVals))
end
println("Number of iterations: ", iter)
println("Coefficients:", b)

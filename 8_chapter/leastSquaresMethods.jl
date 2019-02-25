using DataFrames, GLM, Statistics, LinearAlgebra, CSV

data = CSV.read("L1L2data.csv")
xVals, yVals = Array{Float64}(data.X), Array{Float64}(data.Y)
n = length(xVals)
A = [ones(n) xVals]

# Approach A
xBar,yBar = mean(xVals),mean(yVals)
sXX, sXY = ones(n)'*(xVals.-xBar).^2 , dot(xVals.-xBar,yVals.-yBar)
b1A = sXY/sXX
b0A = yBar - b1A*xBar

# Approach B
b1B = cor(xVals,yVals)*(std(yVals)/std(xVals))
b0B = yBar - b1B*xBar

# Approach C
b0C,b1C = A'A \ A'yVals

# Approach D
Adag = inv(A'*A)*A'
b0D,b1D = Adag*yVals

# Approach E
b0E,b1E = pinv(A)*yVals

# Approach F
b0F,b1F = A\yVals

# Approach G
F = qr(A)
Q, R = F.Q, F.R
b0G,b1G = (inv(R)*Q')*yVals

# Approach H
eta,eps = 0.002,10^-6.
b,bPrev = [0,0], [1,1]
while norm(bPrev-b) > eps
    bPrev = b
    b = b - eta*2*A'*(A*b - yVals)
end
b0H,b1H = b[1],b[2]

# Approach I
modelI = lm(@formula(Y ~ X), data)
b0I,b1I = coef(modelI)

# Approach J
modelJ = glm(@formula(Y ~ X), data,Normal())
b0J,b1J = coef(modelJ)

println([b0A,b0B,b0C,b0D,b0E,b0F,b0G,b0H,b0I,b0J])
println([b1A,b1B,b1C,b1D,b1E,b1F,b1G,b1H,b1I,b1J])

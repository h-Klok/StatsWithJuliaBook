using Random, Distributions, NLsolve
Random.seed!(0)

a, b, c = 3, 5, 4
dist = TriangularDist(a,b,c)
n = 2000
samples = rand(dist,n)

m_k(k,data) = 1/n*sum(data.^k)
mHats = [m_k(i,samples) for i in 1:3]

function equations(F, x)
    F[1] = 1/3*( x[1] + x[2] + x[3] ) - mHats[1]
    F[2] = 1/6*( x[1]^2 + x[2]^2 + x[3]^2 + x[1]*x[2] + x[1]*x[3] +
		 x[2]*x[3] ) - mHats[2]
    F[3] = 1/10*( x[1]^3 + x[2]^3 + x[3]^3 + x[1]^2*x[2] + x[1]^2*x[3] +
		 x[2]^2*x[1] + x[2]^2*x[3] + x[3]^2*x[1] + x[3]^2*x[2] +
		 x[1]*x[2]*x[3] ) - mHats[3]
end

nlOutput = nlsolve(equations, [ 0.1; 0.1; 0.1])
sol = sort(nlOutput.zero)
aHat, bHat, cHat = sol[1], sol[3], sol[2]
println("Found estimates for (a,b,c) = ", (aHat, bHat, cHat) , "\n" )
println(nlOutput)
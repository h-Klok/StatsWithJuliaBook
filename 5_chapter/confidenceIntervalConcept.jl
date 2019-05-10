using Random, Distributions
Random.seed!(0)

alpha = 0.05
q=quantile(TriangularDist(-1,1,0),1-alpha/2)
L(obs) = obs - (1-sqrt(alpha))
U(obs) = obs + (1-sqrt(alpha))

mu=5.57
observation = rand(TriangularDist(mu-1,mu+1,mu))
println("Lower bound L: ", L(observation))
println("Upper bound U: ", U(observation))

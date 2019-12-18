using Random, Distributions
Random.seed!(0)

alpha = 0.05
L(obs) = obs - (1-sqrt(alpha))
U(obs) = obs + (1-sqrt(alpha))

mu = 5.57
observation = rand(TriangularDist(mu-1,mu+1,mu))
println("Lower bound L: ", L(observation))
println("Upper bound U: ", U(observation))
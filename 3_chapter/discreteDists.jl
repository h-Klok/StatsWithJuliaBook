using Distributions
dists = [
    DiscreteUniform(10,20),
    Binomial(10,0.5),
    Geometric(0.5),
    NegativeBinomial(10,0.5),
    Hypergeometric(30, 40, 10),
    Poisson(5.5)]

println("Distribution \t\t\t\t\t\t Parameters \t Support")
reshape([dists ;  params.(dists) ;
		((d)->(minimum(d),maximum(d))).(dists) ],
		length(dists),3)

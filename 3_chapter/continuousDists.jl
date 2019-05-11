using Distributions
dists = [
    Uniform(10,20),
    Exponential(3.5),
    Gamma(0.5,7),
    Beta(10,0.5),
    Weibull(10,0.5),
    Normal(20,3.5),
    Rayleigh(2.4),
    Cauchy(20,3.5)]

println("Distribution \t\t\t Parameters \t Support")
reshape([dists ;  params.(dists) ;
		((d)->(minimum(d),maximum(d))).(dists) ],
		length(dists),3)

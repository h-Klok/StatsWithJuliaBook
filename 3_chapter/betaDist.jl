using SpecialFunctions, Distributions

a,b = 0.2, 0.7

betaAB1 = beta(a,b)
betaAB2 = (gamma(a)gamma(b))/gamma(a+b)
betaAB3 = (factorial(a-1)factorial(b-1))/factorial(a+b-1)
betaPDFAB1 = pdf(Beta(a,b),0.75)
betaPDFAB2 = (1/beta(a,b))*0.75^(a-1) * (1-0.75)^(b-1)

println("beta($a,$b)    = $betaAB1,\t$betaAB2,\t$betaAB3 ")
println("betaPDF($a,$b) = $betaPDFAB1,\t$betaPDFAB2")

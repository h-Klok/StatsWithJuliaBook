using QuadGK, SpecialFunctions

g(x) = x^(0.5-1) * MathConstants.e^-x
quadgk(g,0,Inf)[1], sqrt(pi), gamma(1/2),  factorial(1/2-1)
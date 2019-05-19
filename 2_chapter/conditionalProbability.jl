using Random, SpecialFunctions
Random.seed!(1)

n = 2000

probAgivenB(k) = 1- 1/(k+1)
probB(k) = 6/(pi*(k+1))^2

numerical= sum([ probAgivenB(k)*probB(k) for k in 0:n])

analytic = (pi^2 - 6*zeta(3))/pi^2

analytic, numerical

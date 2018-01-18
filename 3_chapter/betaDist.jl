using Distributions

a,b = 0.2, 0.7

(gamma(a)gamma(b))/gamma(a+b) ,
(factorial(a-1)factorial(b-1))/factorial(a+b-1),
beta(a,b),pdf(Beta(a,b),0.75),
(1/beta(a,b))*0.75^(a-1) * (1-0.75)^(b-1)
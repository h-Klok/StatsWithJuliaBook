using HCubature
M = 4
f(x) = (2*pi)^(-length(x)) * exp(-(1/2)*x'x)
hcubature(f,[-M,M],[-M,M])

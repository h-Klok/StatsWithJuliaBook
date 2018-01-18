using QuadGK

g(x) = x^(0.5-1) * e^-x
quadgk(g,0,Inf),sqrt(pi)
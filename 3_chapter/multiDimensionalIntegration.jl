using HCubature

M = 4.5
maxD = 10

f(x) = (2*pi)^(-length(x)/2) * exp(-(1/2)*x'x)

for n in 1:maxD
    a = -M*ones(n)
    b = M*ones(n)
    I,e = hcubature(f, a, b, maxevals = 10^7)
    println("n = $(n), integral = $(I), error (estimate) = $(e)")
end
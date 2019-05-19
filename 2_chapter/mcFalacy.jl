using Random, StatsBase
Random.seed!(1)

A = Set(['a','e','i','o','u'])
B = Set(['x','y','z'])
omega = 'a':'z'

N = 10^6

println("mcEst1 \t \tmcEst2")
for _ in 1:5
    mcEst1 = sum([in(sample(omega),A) || in(sample(omega),B) for _ in 1:N])/N
    mcEst2 = sum([in(sample(omega),union(A,B)) for _ in 1:N])/N
    println(mcEst1,"\t",mcEst2)
end

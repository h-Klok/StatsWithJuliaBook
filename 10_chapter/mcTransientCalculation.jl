using LinearAlgebra
P = [   0   1   0   0   0;
        1/4 0   1/4 1/4 1/4;
        0   1/2 0   0   1/2;
        0   1/2 0   0   1/2;
        0   0   0   0   1]
T = P[1:4,1:4]
p0 = [1 0 0 0]
for n in 1:10
    println(first(p0*sum([T^k for k in 0:n])*ones(4)))
end
println("Using inverse: ", first(p0*inv(I-T)*ones(4)))
println("Eigenvalues of T: ", sort(eigvals(T)))
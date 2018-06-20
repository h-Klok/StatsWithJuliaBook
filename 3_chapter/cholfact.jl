# update this example to have a proper computation of chol-fact 
-- perhaps compare the pacakge computation (sort of like below) to a hard coded computation - e.g. like e.g. 6.32 in LeonGarcia.
srand(19)
A = rand(3,3)
sigma = A + A'
eigvals(sigma)
#https://docs.julialang.org/en/latest/stdlib/SparseArrays/
B = cholfact(sigma)
B[:U]
Array(B)
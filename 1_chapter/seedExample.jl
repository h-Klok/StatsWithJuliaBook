using Random

Random.seed!(1974)
println("Seed 1974: ",rand(),"\t", rand(), "\t", rand())
Random.seed!(1975)
println("Seed 1975: ",rand(),"\t", rand(), "\t", rand())
Random.seed!(1974)
println("Seed 1974: ",rand(),"\t", rand(), "\t", rand())

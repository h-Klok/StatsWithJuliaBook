srand(1)
function estVar(n)
    sample = rand(n)
    sum((sample - 0.5).^2)/n
end

N = 10^7
for n in 5:5:30
    biasVar = mean([estVar(n) for _ in 1:N]) - 1/12
    biasStd = mean([sqrt(estVar(n)) for _ in 1:N]) - sqrt(1/12)
    println("n = ",n, " Var bias: ", round(biasVar,5),
           	    "\t Std bias: ", round(biasStd,5))
end

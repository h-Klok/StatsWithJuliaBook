using Distributions, Random, Plots, LaTeXStrings; pyplot()

seed = 1
N = 100
lamGrid = 0.01:0.01:0.99

theorM(lam) = mean(Uniform(0,2*lam*(1-lam)))
estM(lam) = mean(rand(Uniform(0,2*lam*(1-lam)),N))

function estM(lam,seed)
    Random.seed!(seed)
    estM(lam)
end

trueM = theorM.(lamGrid)
estM0 = estM.(lamGrid)
estMCRN = estM.(lamGrid,seed)

plot(lamGrid,trueM,
	c=:black, label="Expected curve")
plot!(lamGrid,estM0,
	c=:blue, label="No CRN estiamte")
plot!(lamGrid,estMCRN,
	c=:red, label="CRN estimate", 
	xlims=(0,1), ylims=(0,0.4), xlabel=L"\lambda", ylabel = "Mean")
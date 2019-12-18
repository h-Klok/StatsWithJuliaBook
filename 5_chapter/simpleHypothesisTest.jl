using Distributions, StatsBase, Plots, LaTeXStrings; pyplot()

mu0, mu1, sd, tau  = 15, 18, 2, 17.5
dist0, dist1 = Normal(mu0,sd), Normal(mu1,sd)
grid = 5:0.1:25
h0grid, h1grid = tau:0.1:25, 5:0.1:tau

println("Probability of Type I error: ", ccdf(dist0,tau))
println("Probability of Type II error: ", cdf(dist1,tau))

plot(grid, pdf.(dist0,grid),
	c=:blue, label="Bolt type 15g")
plot!(h0grid, pdf.(dist0, h0grid), 
	c=:blue, fa=0.2, fillrange=[0 1], label="")
plot!(grid, pdf.(dist1,grid), 
	c=:green, label="Bolt type 18g")
plot!(h1grid, pdf.(dist1, h1grid), 
	c=:green, fa=0.2, fillrange=[0 1], label="")
plot!([tau, 25],[0,0],
	c=:red, lw=3, label="Rejection region", 
	xlims=(5, 25), ylims=(0,0.25) , legend=:topleft,
    xlabel="x", ylabel="Density")
annotate!([(16, 0.02, text(L"\beta")),(18.5, 0.02, text(L"\alpha")),
            (15, 0.21, text(L"H_0")),(18, 0.21, text(L"H_1"))])
using Distributions, Plots, LaTeXStrings; pyplot()

dist = TriangularDist(0,2,1)
xGrid = 0:0.01:2
uGrid = 0:0.01:1

p1 = plot( xGrid, pdf.(dist,xGrid), c=:blue, 
		xlims=(0,2), ylims=(0,1.1), 
		xlabel="x", ylabel="f(x)")
p2 = plot( xGrid, cdf.(dist,xGrid), c=:blue, 
		xlims=(0,2), ylims=(0,1), 
		xlabel="x", ylabel="F(x)")
p3 = plot( uGrid,quantile.(dist,uGrid), c=:blue, 
		xlims=(0,1), ylims=(0,2), 
		xlabel="u", ylabel=(L"F^{-1}(u)"))

plot(p1, p2, p3, legend=false, layout=(1,3), size=(1200, 400))
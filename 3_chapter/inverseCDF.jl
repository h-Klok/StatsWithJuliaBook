using Plots, LaTeXStrings; pyplot()

xGrid = 0:0.01:10
uGrid = 0:0.01:1
busy = 0.8

F(t)= t<=0 ? 0 : 1 - busy*exp(-(1-busy)t)

infimum(B) = isempty(B) ? Inf : minimum(B)
invF(u) = infimum(filter((x) -> (F(x) >= u),xGrid))

p1 = plot(xGrid,F.(xGrid), c=:blue, xlims=(-0.1,10), ylims=(0,1), 
	xlabel=L"x", ylabel=L"F(x)")

p2 = plot(uGrid,invF.(uGrid), c=:blue, xlims=(0,0.95), ylims=(0,maximum(xGrid)),
	xlabel=L"u", ylabel=L"F^{-1}(u)")
    
plot(p1, p2, legend=:none, size=(800, 400))
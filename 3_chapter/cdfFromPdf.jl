using Plots, LaTeXStrings; pyplot()

f2(x) = (x<0 ? x+1 : 1-x)*(abs(x)<1 ? 1 : 0)
a, b = -1.5, 1.5
delta = 0.01

F(x) = sum([f2(u)*delta for u in a:delta:x])

xGrid = a:delta:b
y = [F(u) for u in xGrid]
plot(xGrid, y, c=:blue, xlims=(a,b), ylims=(0,1), 
	xlabel=L"x", ylabel=L"F(x)", legend=:none)

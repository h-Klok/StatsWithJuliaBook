using Plots, LaTeXStrings, Measures; pyplot()

delta = 0.01
grid = 0:delta:1
f(x,y) = 9/8*(4x+y)*sqrt((1-x)*(1-y))
z = [f(x,y) for y in grid, x in grid]

densityIntegral = sum(z)*delta^2
println("2-dimensional Riemann sum over density: ", densityIntegral)

probB = sum([sum([f(x,y)*delta for y in x:delta:1])*delta for x in grid])
println("2-dimensional Riemann sum to evaluate probability: ", probB)

p1 = surface(grid, grid, z, 
	c=cgrad([:blue, :red]), la=1, camera=(60,50),
	ylabel="y", zlabel=L"f(x,y)", legend=:none)
p2 = contourf(grid, grid, z, 
	c=cgrad([:blue, :red]))
p2 = contour!(grid, grid, z, 
	c=:black, xlims=(0,1), ylims=(0,1), ylabel="y", ratio=:equal)

plot(p1, p2, size=(800, 400), xlabel="x", margin=5mm)
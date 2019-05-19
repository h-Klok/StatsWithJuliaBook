using Plots

grid = range(0, stop=1.5*pi, length=100)
data  = abs.(0.1 * randn(100) + sin.(3*grid))

p1 = plot(grid, data, line=:blue, legend=false)
p2 = plot(grid, data, proj=:polar, line=:blue, legend=false)
plot(p1, p2, layout = 2)

using PyPlot

support = 0:0.01:1
f(x,y) = 9/8*(4x+y)*sqrt((1-x)*(1-y))

z = [ f(j,i) for i in support, j in support]

fig = figure(figsize=(10,5))
ax1 = fig.add_subplot(121)
contourf(support, support, z, cmap="coolwarm")

ax2 = fig.add_subplot(122, projection = "3d")
ax2.view_init(elev=70, azim=-80)
plot_surface(support, support, z, cmap="coolwarm")

using Distributions, StatsBase, PyCall, PyPlot
patch = pyimport("matplotlib.patches")

mu0, mu1, sd  = 15, 18, 2
tau = 17.5
dist0 = Normal(mu0,sd)
dist1 = Normal(mu1,sd)

gridMin, gridMax = 5, 25
grid = gridMin:0.1:gridMax

fig = figure(figsize=(6,6))
ax = fig.add_subplot(1,1,1)

plot(grid,pdf(dist0,grid),"b", label="Bolt type 15g")
plot(grid,pdf(dist1,grid),"g", label="Bolt type 18g")
plot([tau,gridMax],[0,0],"r",lw=3,label="Rejection region")

verts1 = [ [[tau,0.0]]; [[i,pdf(dist0,i)] for i in tau:0.1:gridMax] ;
    [[gridMax,0.0]] ]
poly1 = patch.Polygon(verts1, fc="blue", ec="0.5",alpha=0.2)

verts2 = [ [[gridMin,0.0]]; [[i,pdf(dist1,i)] for i in gridMin:0.1:tau] ;
    [[tau,0.0]] ]
poly2 = patch.Polygon(verts2, fc="green", ec="0.5",alpha=0.2)
ax.add_artist(poly1)
ax.add_artist(poly2)

xlim(gridMin,gridMax)
ylim(0,0.25)
legend(loc="upper left")

println("Probability of Type I error: ", ccdf(dist0,tau))
println("Probability of Type II error: ", cdf(dist1,tau))

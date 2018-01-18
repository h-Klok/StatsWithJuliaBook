using DataFrames, Distributions, PyPlot

data = readtable("BrisGCtemp.csv")
Bris = data[4]
GC = data[5]

sigB = std(Bris)
sigG = std(GC)
covBG = cov(Bris,GC) 

meanVect = [ mean(Bris) , mean(GC)]

covMat =  [ sigB^2             covBG; 
            covBG              sigG^2]

biNorm = MvNormal(meanVect,covMat)

support = 15:0.1:40
Z = [ pdf(biNorm,[i,j]) for i in support, j in support ]

fig = figure(figsize=(10,5))
ax = fig[:add_subplot](121)
plot(Bris, GC, ".", markersize=2, label="scatter")
CS = contour(support, support, Z', levels=[0.001, 0.005, 0.02])

ax = fig[:add_subplot](122, projection = "3d")
#ax[:plot_surface](support, support, Z, rstride=1, cstride=1, lw=1, cmap="coolwarm", antialiased=false);
plot_surface(support, support, Z, rstride=1, cstride=1, lw=0, antialiased=false, cmap="coolwarm",);
#savefig("bivariateNormal.png")
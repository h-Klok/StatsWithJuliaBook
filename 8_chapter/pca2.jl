using MultivariateStats, RDatasets, PyPlot

iris = dataset("datasets", "iris")

x = convert(Array, iris[:,1:4])'
y = iris[:,5]

model = fit(PCA, x; maxoutdim=3)

# obtain PC values for each observation
pcValues = transform(model, x)

# convert back to approximate x-values
xApprox = reconstruct(model, pcValues)

x

# group results by testing set labels for color coding
setosa = xApprox[:, y .== "setosa"]
versicolor = xApprox[:, y .== "versicolor"]
virginica = xApprox[:, y .== "virginica"]

# visualize first 3 principal components in 3D interacive plot
scatter3D(setosa[1,:],setosa[2,:],setosa[3,:],"b")
scatter3D(versicolor[1,:],versicolor[2,:],versicolor[3,:],"r")
scatter3D(virginica[1,:],virginica[2,:],virginica[3,:],"g");
xlabel("PC1")
xlabel("PC2")
xlabel("PC3")
savefig("3pcs_iris_plot.pdf")

# need to plot scree plot, showing eivenvalues and total variance for each PC! 
model.proj

# fieldnames(M) # used to find fields
model.proj[:,1]

X = [ cov( model.proj[:,i], model.proj[:,j]) for i in 1:3, j in 1:3 ] #covariance matrix of the principal components

# scree plot
x = sort(a, rev=true)
plot( [1,2,3], x, "bo-", label="", label="ratio of eigenvalues");
plot( [1,2,3], cumsum(x), "r", label="Cumulative explained \nvariance")
legend(loc="upper left")
xlabel("Principal component")
ylabel("Variance QQQQ needs fixing");
savefig("screePlot.pdf")

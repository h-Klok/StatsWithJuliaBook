using RDatasets, StatsPlots

iris = dataset("datasets", "iris")
@df iris violin(:Species, :SepalLength, 
	fill=:blue, xlabel="Species", ylabel="Sepal Length", legend=false) 

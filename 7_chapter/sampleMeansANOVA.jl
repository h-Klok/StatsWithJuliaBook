using CSV, Statistics

rfile(name) = CSV.read(name, header=false)[:,1]
data = rfile.(["../data/machine1.csv",
		"../data/machine2.csv",
		"../data/machine3.csv"])
println("Sample means for each treatment: ",round.(mean.(data),digits=2))
println("Overall sample mean: ",round(mean(vcat(data...)),digits=2))
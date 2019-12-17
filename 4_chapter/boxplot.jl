using CSV, StatsPlots; pyplot()

data1 = CSV.read("../data/machine1.csv", header=false)[:,1]
data2 = CSV.read("../data/machine2.csv", header=false)[:,1]
data3 = CSV.read("../data/machine3.csv", header=false)[:,1]

boxplot([data1,data2,data3], c=[:blue :red :green], label="", 
	xticks=([1:1:3;],["1", "2", "3"]), xlabel="Machine type",
	ylabel="Pipe Diameter (mm)")
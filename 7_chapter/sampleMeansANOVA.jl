using CSV

rfile(name) = CSV.read(name, header=false, allowmissing=:none)[:,1]
data = rfile.(["machine1.csv","machine2.csv","machine3.csv"])
println("Sample means for each treatment: ",round.(mean.(data),digits=2))
println("Overall sample mean: ",round(mean(vcat(data...)),digits=2))

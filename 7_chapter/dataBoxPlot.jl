using CSV, PyPlot

data1 = CSV.read("machine1.csv", header=false, allowmissing=:none)[:,1]
data2 = CSV.read("machine2.csv", header=false, allowmissing=:none)[:,1]
data3 = CSV.read("machine3.csv", header=false, allowmissing=:none)[:,1]

boxplot([data1,data2,data3])
xlabel("Machine type")
ylabel("Bolt Diameter (mm)")
println("n1 = ",length(data1),",\tn2 = ",length(data2), ",\tn3 = ",length(data3))

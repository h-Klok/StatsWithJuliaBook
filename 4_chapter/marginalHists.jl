using StatsPlots, CSV

data = CSV.read("temperatures.csv")
marginalhist(data[4], data[5], bins=30, fill=:bluesreds, xlabel="City A Temp", ylabel="City B Temp")


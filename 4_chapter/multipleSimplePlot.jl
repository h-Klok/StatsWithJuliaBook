using DataFrames, CSV, Statistics, Dates, Plots, Measures; pyplot()

data = CSV.read("../data/temperatures.csv")
brisbane = data.Brisbane
goldcoast = data.GoldCoast

diff = brisbane - goldcoast
dates = [Date(
            Year(data.Year[i]), 
            Month(data.Month[i]), 
            Day(data.Day[i])
        ) for i in 1:nrow(data)]

fortnightRange = 250:263
brisFortnight = brisbane[fortnightRange]
goldFortnight = goldcoast[fortnightRange]

default(xlabel="Time", ylabel="Temperature")
default(label=["Brisbane" "Gold Coast"])

p1 = plot(dates, [brisbane goldcoast], 
        c=[:blue :red])
p2 = plot(dates[fortnightRange], [brisFortnight goldFortnight],
        c=[:blue :red], m=(:dot, 5, Plots.stroke(1)))
p3 = plot(dates, diff, 
        c=:black, ylabel="Temperature Difference",legend=false)
p4 = histogram(diff, bins=-4:0.5:6, 
        ylims=(0,140), legend = false,
        xlabel="Temperature Difference", ylabel="Frequency")
plot(p1,p2,p3,p4, size = (800,500), margin = 5mm)
using DataFrames, CSV, Dates, StatsBase, Plots, TimeSeries; pyplot()

data = CSV.read("../data/temperatures.csv",copycols = true)
brisbane = data.Brisbane
dates = [Date(
            Year(data.Year[i]), 
            Month(data.Month[i]), 
            Day(data.Day[i])
        ) for i in 1:nrow(data)]

window1, window2 = 7, 14
d1 = values(moving(mean,TimeArray(dates,brisbane),window1))
d2 = values(moving(mean,TimeArray(dates,brisbane),window2))

grid = (2pi:-2pi/365:0) .+ pi/2
monthsNames = Dates.monthname.(dates[1:31:365])

plot(grid, d1[1:365], 
    c=:blue, proj=:polar, label="Brisbane weekly average temp.")
plot!(grid, d2[1:365], 
    xticks=([mod.((11pi/6:-pi/6:0) .+ pi/2,2pi) ;], monthsNames),
    c=:red, proj=:polar, 
    label="Brisbane fortnightly average temp.", legend=:outerbottom)
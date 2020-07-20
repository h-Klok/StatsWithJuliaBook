using CSV, TimeSeries, Dates, Statistics, Measures, Plots, StatsPlots; pyplot()

df = CSV.read("../data/oneOnEpsilonBlogs.csv",copycols = true)

tsA = TimeArray(Date.(df.Day,Dates.DateFormat("m/d/y")),df.Users)
tsB = moving(mean,tsA,7,padding = true)
tsC = TimeArray(timestamp(tsA), values(tsA) - values(tsB))

dow = dayofweek.(timestamp(tsA));
dayDiv = [filter((x)->!isnan(x) && x >= -50 && x <= 50, values(tsC)[dow .== d]) 
            for d in 1:7]

start2020 = findfirst((d)->Year(d)==Year(20),timestamp(tsA))
indexLast = length(tsA)
indexes2020 = start2020:indexLast

dayGroup1 = [7] #Sun
dayGroup2 = [1,6] #Mon,Sat
dayGroup3 = [2,3,4,5] #Tue, Wed, Thu, Fri
dayGroups = [dayGroup1, dayGroup2, dayGroup3]
groupDivs = [vcat(dayDiv[g]...) for g in dayGroups]

default(legend = :topleft)
labels = ["Daily" "7 Day Average"]
p1 = plot(1:indexLast, [values(tsA) values(tsB)], c=[:blue :red],label = labels,
        xlabel = "Day", ylabel = "Daily Users", ylim = (0,200))

p2 = plot(indexes2020, [values(tsA)[indexes2020] values(tsB)[indexes2020]],
        c=[:blue :red], label=labels, xlabel="Day in 2020",
        ylabel="Daily Users",ylim=(0,200))

p3 = plot(1:indexLast, values(tsC),label = labels, c=:black,
        xlabel="Day",ylabel="Variation",ylim=(-50,50),legend=false)

p4 = plot(indexes2020, values(tsC)[indexes2020],label = labels, c=:black,
         xlabel="Day in 2020",ylabel="Variation",ylim=(-50,50),legend=false)

dayNames = dayname.(timestamp(tsA)[4:10])
p5 = density(dayDiv, label = hcat(dayNames...),legend = :topright,
                xlabel = "Variation", ylabel = "Frequency",)

dayGroupNames = ["Sun", "Mon+Sat", "Tue+Wed+Thu+Fri"]
p6 = density(groupDivs,label = hcat(dayGroupNames...), legend = :topright,
                xlabel = "Variation", ylabel = "Frequency",c=[:blue :red :green])

plot(p1, p2, p3, p4, p5, p6, layout=(3,2), size = (900,600), margin = 5mm)
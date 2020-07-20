using CSV,DataFrames,Dates,GLM,Statistics,LinearAlgebra,Measures,Plots; pyplot()

df = CSV.read("../data/oneOnEpsilonBlogs.csv",copycols = true)
len = size(df)[1]

dow = dayofweek.(Date.(df.Day,Dates.DateFormat("m/d/y")))
dayGroups = [[7], [1,6], [2,3,4,5]]
inds = [[in(d,grp) for d in dow] for grp in dayGroups]
df2 = DataFrame(Time=1:len,Users=df.Users,
                Group1=inds[1],Group2=inds[2])

trainRange1, futureRange1 = 100:130, 130:180
trainRange2, futureRange2 = 200:300, 300:320 
trainRange3, futureRange3 = 400:500, 500:600 
trainRange4, futureRange4 = 560:600, 600:630

function forecast(trainRange,futureRange)
    model = lm(@formula(Users ~ Time + Group1 + Group2),df2[trainRange,:])
    pred(time) =  dot(coef(model),[1,time,inds[1][time],inds[2][time]])
    model, pred.(trainRange), pred.(futureRange)
end

function forecastPlot(train,future)
    p = plot(train[1], df.Users[train[1]], label = "Observed Users",
            xlabel = "Day", ylabel = "Daily Users", c=:blue)
        plot!(train[1], train[2], label = "Train", c=:red)
        plot!(future[1], future[2], label = "Forecast",c=:magenta)
        plot!(future[1], df.Users[future[1]], label = "Actual Users",c=:green)
    return p
end

model1, train1, fcst1 = forecast(trainRange1,futureRange1)
println(model1)

default(legend = :topleft)
p1 = forecastPlot((trainRange1, train1), (futureRange1, fcst1))

_, train2, fcst2 = forecast(trainRange2, futureRange2)
default(legend = false)
p2 = forecastPlot((trainRange2, train2), (futureRange2, fcst2))

_, train3, fcst3 = forecast(trainRange3, futureRange3)
p3 = forecastPlot((trainRange3, train3), (futureRange3, fcst3))

_, train4, fcst4 = forecast(trainRange4, futureRange4)
p4 = forecastPlot((trainRange4, train4), (futureRange4, fcst4))
plot(p1, p2, p3, p4, size = (900,600), margin = 5mm)
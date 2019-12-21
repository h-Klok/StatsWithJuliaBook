using CSV, DataFrames, CategoricalArrays

data = CSV.read("../data/purchaseData.csv", copycols = true)
println("Levels of Grade: ", levels(data.Grade))
println("Data points: ", nrow(data))

n = sum(.!(ismissing.(data.Grade)))
println("Non-missing data points: ", n)
data2 = dropmissing(data[:,[:Grade]],:Grade)

gradeInQuestion = "E"
indicatorVector = data2.Grade .== gradeInQuestion
numSuccess = sum(indicatorVector)
phat = numSuccess/n
serr = sqrt(phat*(1-phat)/n)

alpha = 0.05
confidencePercent = 100*(1-alpha)
zVal = quantile(Normal(),1-alpha/2)
confInt = (phat - zVal*serr, phat + zVal*serr)

println("\nOut of $n non-missing observations, "*
        "$numSuccess are at level $gradeInQuestion.")
println("Hence a point estimate for the proportion "*
        "of grades at level $gradeInQuestion is $phat.")
println("A $confidencePercent% confidence interval for "*
        "the proprotion of level $gradeInQuestion is:\n$confInt.")
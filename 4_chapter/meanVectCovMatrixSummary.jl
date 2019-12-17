using DataFrames, CSV, Statistics

data = CSV.read("../data/temperatures.csv", copycols=true)
brisT = data.Brisbane
gcT = data.GoldCoast

sigB = std(brisT)
sigG = std(gcT)
covBG = cov(brisT, gcT)

meanVect = [mean(brisT) , mean(gcT)]
covMat = [sigB^2  covBG
          covBG   sigG^2]

outfile = open("../data/mvParams.jl","w")
write(outfile,"meanVect = $meanVect \ncovMat = $covMat")
close(outfile)
print(read("../data/mvParams.jl", String))
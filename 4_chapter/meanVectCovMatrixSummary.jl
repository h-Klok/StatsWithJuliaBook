using DataFrames, CSV, Statistics

data = CSV.read("temperatures.csv")
brisT = data[:, 4]
gcT = data[:, 5]

sigB = std(brisT)
sigG = std(gcT)
covBG = cov(brisT, gcT)

meanVect = [mean(brisT) , mean(gcT)]
covMat = [sigB^2  covBG
          covBG   sigG^2]

outfile = open("mvParams.jl","w")
write(outfile,"meanVect = $meanVect \ncovMat = $covMat")
close(outfile)
print(read("mvParams.jl", String))

using DataFrames

data = readtable("temperatures.csv")
brisT = data[4]
gcT = data[5]

sigB = std(brisT)
sigG = std(gcT)
covBG = cov(brisT,gcT) 

meanVect = [ mean(brisT) , mean(gcT)]

covMat =  [ sigB^2  covBG; 
            covBG   sigG^2];

outfile = open("mvParams.jl","w") 
println(outfile,"meanVect = $meanVect")
println(outfile,"covMat = $covMat")
close(outfile);

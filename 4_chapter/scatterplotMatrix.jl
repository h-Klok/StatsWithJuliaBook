using RDatasets, Plots, Measures; pyplot()

data = dataset("datasets", "iris")
println("Number of rows: ", nrow(data))

insertSpace(name) = begin
    i = findlast(isuppercase,name)
    name[1:i-1]*" "*name[i:end]
end

featureNames = insertSpace.(string.(names(data)))[1:4]
println("Names of features:\n\t", featureNames)

speciesNames = unique(data.Species)
speciesFreqs = [sn => sum(data.Species .== sn) for sn in speciesNames]
println("Frequency per species:\n\t", speciesFreqs)

default(msw = 0, ms = 3)

scatters = [ 
    scatter(data[:,i], data[:,j], c=[:blue :red :green], group=data.Species, 
        xlabel=featureNames[i], ylabel=featureNames[j], legend = i==1 && j==1) 
    for i in 1:4, j in 1:4 ]

plot(scatters..., size=(1200,800), margin = 4mm)
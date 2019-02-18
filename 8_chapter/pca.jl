using MultivariateStats, RDatasets, PyPlot

data = dataset("datasets", "iris")

x = [ ( data[i,j] - mean(data[j]) )/std(data[j])' for i in 1:size(data)[1], j in 1:4 ]' # Standardise the dataframe 
y = data[:,5]

model = fit(PCA, x; maxoutdim=4)

pcVar = principalvars(model) ./ tvar(model)
cumVar = cumsum(pcVar)

pcValues = transform(model, x)
# convert back to approximate x-values, we can see values are approx the same as "x"
xApprox = reconstruct(model, pcValues) 

figure(figsize=(10,5))
subplot(121)
plot( 1:length(pcVar) , pcVar,"bo-", label="Variance due to PC")
plot( 1:length(cumVar) , cumVar,"ro-", label="Cumulative Variance");
legend(loc="lower left")
ylim(0,1)

subplot(122)
plot( pcValues'[1:50,1], pcValues'[1:50,2], "b.",label="setosa")
plot( pcValues'[51:100,1], pcValues'[51:100,2], "r.",label="versicolor")
plot( pcValues'[101:150,1], pcValues'[101:150,2], "g.",label="virginica")
legend(loc="lower left")
xlabel("PC 1")
ylabel("PC 2");
using DataFrames, PyPlot

imputedData = readtable("purchaseDataImputed.csv")
types = unique(imputedData[:Type])
data = Array{Any}(length(types))

for (i, t) in enumerate(types)
    data[i] = imputedData[imputedData[:Type] .== t, :Price] 
end

boxplot(data, widths=0.25, sym="b+");
xticks(1:5, types);
xlabel("Types")
ylabel("Price")
savefig("boxplot.pdf")

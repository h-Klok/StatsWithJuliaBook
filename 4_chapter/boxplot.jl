using DataFrames, PyPlot, CSV

imputedData = CSV.read("purchaseDataImputed.csv")
groupedData = by(imputedData, :Type, Prices = :Price => x -> [x], sort=true)
boxplot(groupedData.Prices, widths=0.25, sym="b+")
xticks(axes(groupedData, 1), groupedData.Type)
xlabel("Types")
ylabel("Price")
savefig("boxplot.pdf")

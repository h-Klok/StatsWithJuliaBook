using DataFrames, CSV, PyPlot

df = CSV.read("companyData.csv")

types = unique(df.Type)
@assert length(unique(df[df.Type .== t, :Year] for t in types)) == 1
years = df[df.Type .== "A", :Year]
sizeA = df[df.Type .== "A", :MarketCap]
sizeB = df[df.Type .== "B", :MarketCap]
sizeC = df[df.Type .== "C", :MarketCap]

stackplot(years, sizeA, sizeB, sizeC, colors=["b", "r","g"], labels = types)
legend(loc="upper left")
xlim(minimum(years),maximum(years))
xticks(years)
xlabel("Years")
ylabel("MarketCap")

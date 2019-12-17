using CSV, CategoricalArrays, Plots; pyplot()

df = CSV.read("../data/companyData.csv")
companies = levels(df.Type)

year2012 = df[df.Year .== 2012, :MarketCap]
year2016 = df[df.Year .== 2016, :MarketCap]

p1 = pie(companies, year2012, title="2012 Market Cap \n by company")
p2 = pie(companies, year2016, title="2016 Market Cap \n by company")
plot(p1, p2, size=(800, 400))
using DataFrames, CSV, PyPlot

df = CSV.read("companyData.csv")

types = unique(df.Type)

year2012 = df[df.Year .== 2012, :MarketCap]
year2016 = df[df.Year .== 2016, :MarketCap]

subplot(121)
pie(year2012, colors=["b","r","g"], labels = types, startangle=90)
axis("equal")
title("2012 Market Cap \n by company")

subplot(122)
pie(year2016, colors=["b","r","g"], labels = types, explode=[0.1, 0.1, 0.5],
	startangle=90)
axis("equal")
title("2016 Market Cap \n by company")

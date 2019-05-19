using RDatasets, StatsPlots

iris = dataset("datasets", "iris")
@df iris andrewsplot(:Species, cols(1:4), line=(fill=[:blue :red :green]), legend=:topleft)

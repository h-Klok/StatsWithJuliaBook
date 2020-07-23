using Pkg
packages = [("BSON","0.2.6"),
            ("Calculus","0.5.1"),
            ("CategoricalArrays","0.8.1"),
            #("Clustering","0.14.1"),
            ("Combinatorics","1.0.2"),
            ("CSV","0.6.2"),
            ("DataFrames","0.21.2"),
            #("DataStructures","0.17.18"),
            #("DecisionTree","0.10.3"),
            ("DifferentialEquations","6.14.0"),
            ("Distributions","0.23.4"),
            ("Flux","0.10.4"),
            ("GLM","1.3.9"),
            #("HCubature","1.4.0"),
            ("HypothesisTests","0.10.0"),
            #("HTTP","0.8.15"),
            # ("IJulia",),
            #("Images","0.22.2"),
            #("JSON","0.21.0"),
            # ("Juno",),
            ("KernelDensity","0.5.1"),
            ("LaTeXStrings","1.1.0"),
            #("LIBSVM","0.4.0"),
            #("LightGraphs","1.3.3"),
            ("Measures","0.3.1"),
            #("MLDatasets","0.5.2"),
            ("MultivariateStats","0.7.0"),
            #("NLsolve","4.4.0"),
            ("Plots","1.4.3"),
            ("PyCall","1.91.4"),
            ("PyPlot","2.9.0"),
            ("QuadGK","2.3.1"),
            ("RCall","0.13.7"),
            ("RDatasets","0.6.9"),
            ("Roots","1.0.2"),
            ("SpecialFunctions","0.10.3"),
            ("StatsBase","0.33.0"),
            ("StatsModels","0.6.11"),
            ("StatsPlots","0.14.6"),
            #("TimeSeries","0.18.0")
             ]

for (pN,pV) in packages
    Pkg.add(Pkg.PackageSpec(;name=pN,version=pV))
end

@info "Precompiling packages - this will take a while"
Pkg.precompile()

#@info "Packages not precompiled.\n If you wish to precompile (on Julia V1.3 or above) use `Pkg.precompile()`."

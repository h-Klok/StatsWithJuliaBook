for eps in [0.1, 0.05, 0.02, 0.01]
    n = ceil(1/eps^2)
    println("For epsilon = $eps set n = $n")
end
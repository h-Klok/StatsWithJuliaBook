N, faces = 10^6, 1:6

products = [i*j for i in faces, j in faces]
outcomes = sort!(unique(products))
mcData = [rand(faces)*rand(faces) for _ in 1:N]

analytic = [count(x-> x == i, products) for i in outcomes]/(length(faces)^2)
monteCarlo = [count(x-> x == i ,mcData) for i in outcomes]/N

println("Analytic and numerical estimates for the probaility of each event")
for i in 1:length(outcomes)
    println("P(X=$(outcomes[i])): ", round(analytic[i],3)," ", round(monteCarlo[i],3))
end
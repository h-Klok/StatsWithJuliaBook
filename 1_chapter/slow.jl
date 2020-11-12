using Statistics

@time begin
    data = Float64[]
    for _ in 1:10^6
        group = Float64[]
        for _ in 1:5*10^2
            push!(group,rand())
        end
        push!(data,mean(group))
    end
    println("98% of the means lie in the estimated range: ",
                (quantile(data,0.01),quantile(data,0.99)) )
end
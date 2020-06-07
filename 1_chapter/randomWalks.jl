using Plots, Random, Measures; pyplot()

function path(rng, alpha, n=5000)
    x, y = 0.0, 0.0
    xDat, yDat = [], []
    for _ in 1:n
        flip = rand(rng,1:4)
        if flip == 1
            x += 1
        elseif flip == 2
            y += 1
        elseif flip == 3
            x -= (2+alpha)*rand(rng)
        elseif flip == 4
            y -= (2+alpha)*rand(rng)
        end
        push!(xDat,x)
        push!(yDat,y)
    end
    return xDat, yDat
end

alphaRange = [0.2, 0.21, 0.22]

default(xlabel = "x", ylabel = "y", xlims=(-150,50), ylims=(-250,50))
p1 = plot(path(MersenneTwister(27), alphaRange[1]), c=:blue)
p1 = plot!(path(MersenneTwister(27), alphaRange[2]), c=:red)
p1 = plot!(path(MersenneTwister(27), alphaRange[3]), c=:green) 

rng = MersenneTwister(27)
p2 = plot(path(rng, alphaRange[1]), c=:blue)
p2 = plot!(path(rng, alphaRange[2]), c=:red)
p2 = plot!(path(rng, alphaRange[3]), c=:green) 

plot(p1, p2, size=(800, 400), legend=:none, margin=5mm)
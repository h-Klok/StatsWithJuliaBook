using PyPlot, Random

N = 5000

function path(rng,alpha)
    x, y = 0.0, 0.0
    xDat, yDat = [], []
    for _ in 1:N
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
    return xDat,yDat
end

alphaRange = 0.2:0.01:0.22
figure(figsize=(12,5))

colors = ["b","r","g"]
subplot(121)
xlim(-150,50)
ylim(-250,50)
for i in 1:length(alphaRange)
    xDat,yDat = path(MersenneTwister(27),alphaRange[i])
    plot(xDat,yDat,color = colors[i])
end

colors = ["b","r","g"]
subplot(122)
xlim(-150,50)
ylim(-250,50)
rng = MersenneTwister(27)
for i in 1:length(alphaRange)
    xDat,yDat = path(rng,alphaRange[i])
    plot(xDat,yDat,color = colors[i])
end

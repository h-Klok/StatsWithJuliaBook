using Distributions, PyPlot

mu1, sig1, n1 = 0, 2, 8
mu2, sig2, n2 = 0, 30, 15
dist1 = Normal(mu1, sig1)
dist2 = Normal(mu2, sig2)

N = 10^6
tdArray = Array{Tuple{Float64,Float64}}(undef,N)

df(s1,s2,n1,n2) =
    (s1^2/n1 + s2^2/n2)^2 / ( (s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1) )

for i in 1:N
    x1Data = rand(dist1, n1)
    x2Data = rand(dist2, n2)

    x1Bar,x2Bar = mean(x1Data),mean(x2Data)
    s1,s2 = std(x1Data),std(x2Data)

    tStat = (x1Bar - x2Bar) / sqrt(s1^2/n1 + s2^2/n2)

    tdArray[i] = (tStat , df(s1,s2,n1,n2))
end
sort!(tdArray, by = tdArray -> tdArray[1])

invVal(data,i) = quantile(TDist(data),i/(N+1))

xCoords  = Array{Float64}(undef,N)
yCoords1 = Array{Float64}(undef,N)
yCoords2 = Array{Float64}(undef,N)

for i in 1:N
    xCoords[i] = first(tdArray[i])
    yCoords1[i] = invVal(last(tdArray[i]),i)
    yCoords2[i] = invVal(n1+n2-2,i)
end

plot(xCoords,yCoords1,label="Calcuated v","b.",ms="1.5")
plot(xCoords,yCoords2,label="Fixed v","r.",ms="1.5")
plot([-10,10],[-10,10],"k",lw="0.3")
legend(loc="upper left")
xlim(-7,7)
ylim(-7,7)
xlabel("Theoretical t-distribution quantiles")
ylabel("Simulated t-distribution quantiles")

using Random,PyPlot
Random.seed!(808)

n = 10^6
data = tan.(rand(n)*pi .- pi/2)
averages = accumulate(+,data)./collect(1:n)

plot(1:n,averages,"b")
plot([1,n],[0,0],"k",lw=0.5)
xscale("log")
xlim(0,n)
xlabel(L"$n$")
ylabel("Rolling average")

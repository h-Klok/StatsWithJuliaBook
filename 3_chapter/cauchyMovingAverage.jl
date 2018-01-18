using PyPlot
srand(4)

U() = -pi/2+rand()*pi

function movingAverage(n)
    a, y = 0, fill(NaN,n)
    for i in 1:n
        a += tan(U())
        y[i] = a/i
    end
    return y
end

n = 10^6
plot(1:n,movingAverage(n))
plot([1,n],[0,0],"r-",lw=0.5)
xlabel(L"$n$")
ylabel("Moving \naverage",rotation=0,labelpad=20)
savefig("cauchyMovingAverage.png");

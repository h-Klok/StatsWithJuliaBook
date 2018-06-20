using Distributions, PyPlot
srand(1)

X() = sqrt(-2*log(rand()))*cos(2*pi*rand())
xGrid = -4:0.01:4

plt[:hist]([X() for _ in 1:10^6],50,
    normed = true,ec="k",label="MC estimate")
plot(xGrid,pdf(Normal(),xGrid),"-r",label="PDF")
xlim(-4,4)
xlabel(L"$x$")
ylabel(L"f(x)")
legend(loc="upper right")

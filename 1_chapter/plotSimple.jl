using PyPlot

xGrid = 0:0.1:5
G(x) = 1/2*x^2-2*x
g(x) = x - 2

ax = subplot()
ax.spines["left"].set_position("zero")
ax.spines["right"].set_position("zero")
ax.spines["bottom"].set_position("zero")
ax.spines["top"].set_position("zero")
ax.set_xlim(-1,5)
ax.set_ylim(-3,3)
ax.set_aspect("equal")

plot(xGrid,G.(xGrid),"b",label="G(x)")
plot(xGrid,g.(xGrid),"r",label="g(x)")
legend(loc="upper center")
title(L"Plot of $G(x)= \frac{1}{2}x^2-2x$ and it's derivative")

annotate("The minimum", xy=(2, -2), xytext=(3, -2.5), xycoords="data",
    bbox=Dict("fc"=>"0.8"), arrowprops=Dict("facecolor"=>"black",
    "arrowstyle"=>"->"))

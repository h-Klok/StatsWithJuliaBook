using PyPlot

xGrid = 0:0.01:10
uGrid = 0:0.01:1
busy = 0.8

F(t)= t<=0 ? 0 : 1 - busy*exp(-(1-busy)t)

infimum(B) = isempty(B) ? Inf : minimum(B)
invF(u) = infimum(filter((x) -> (F(x) >= u),xGrid))

figure(figsize=(10,5))
subplots_adjust(wspace=0.3)

subplot(121)
plot(xGrid,F.(xGrid))
xlim(-0.1,10)
ylim(0,1)
xlabel("x")
ylabel("CDF")

subplot(122)
plot(uGrid,invF.(uGrid))
xlim(0,0.95)
ylim(0,maximum(xGrid))
xlabel("u")
ylabel("Inverse CDF")

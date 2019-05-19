using PyPlot

a, c, m = 69069, 1, 2^32
next(z) = (a*z + c) % m

N = 10^6
data = Array{Float64,1}(undef, N)

x = 808
for i in 1:N
    data[i] = x/m
    global x = next(x)
end

figure(figsize=(12,5))
subplot(121)
plot(1:1000,data[1:1000],".")

subplot(122)
plt.hist(data,50, density = true)

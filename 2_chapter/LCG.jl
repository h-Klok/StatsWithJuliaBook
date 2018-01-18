using PyPlot

a = 69069
c = 1
m = 2^32
next(z) = (a*z + c) % m

N = 10^6
data = Array{Float64}(N)

val = 808 
for i in 1:N
    data[i] = val/m
    val = next(val)
end

figure(figsize=(5,5))
subplot(211)
plot(1:1000,data[1:1000],".")
subplots_adjust(hspace=0.0)
subplot(212)
plt[:hist](data,50,ec="black",lw=0.5,normed=true)
savefig("LCG.png")

mean(data), var(data)

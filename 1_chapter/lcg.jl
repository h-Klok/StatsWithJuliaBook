using Plots, LaTeXStrings, Measures; pyplot()

a, c, m = 69069, 1, 2^32
next(z) = (a*z + c) % m

N = 10^6
data = Array{Float64,1}(undef, N)

x = 808
for i in 1:N
    data[i] = x/m
    global x = next(x)
end

p1 = scatter(1:1000, data[1:1000], 
    c=:blue, m=4, msw=0, xlabel=L"n", ylabel=L"x_n")
p2 = histogram(data, bins=50, normed=:true, 
    ylims=(0,1.1), xlabel="Support", ylabel="Density")
plot(p1, p2, size=(800, 400), legend=:none, margin = 5mm)
using PyPlot

function hailLength(x::Int)
    n = 0
    while x != 1
        if x % 2 == 0
            x = Int(x/2)
        else
            x = 3x +1
        end
        n += 1
    end
    return n
end

lengths = [hailLength(x0) for x0 in 2:10^7]

plt.hist(lengths, 1000, density="true")
xlabel("Length")
ylabel("Frequency")

using PyPlot

function hailLength(n::Int)
    x = 0
    while n != 1
        if n % 2 == 0
            n = Int(n/2)
        else
            n = 3n +1
        end
        x += 1
    end
    return x
end

lengths = [hailLength(n) for n in 2:10^7] 

plt[:hist](lengths, 1000, normed="true")
xlabel("Length")
ylabel("Frequency")
savefig("hailstoneLengthHist.png")
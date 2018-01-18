using StatsBase, PyPlot

function proportionFished(gF,sF,numberFished,n,withReplacement = false)

    function fishing()
        fishInPond = [ones(Int64,gF); zeros(Int64,sF)]
        fishCaught = Int64[]

        for fish in 1:numberFished
            fished = rand(fishInPond)
            push!(fishCaught,fished)
            if withReplacement == false
                deleteat!(fishInPond, findfirst(fishInPond,fished))
            end
        end
        sum(fishCaught)
    end

    simulations = [fishing() for _ in 1:n]
    proportions = counts(simulations,0:numberFished)/n
    
    if withReplacement
        stem(0:numberFished,proportions,basefmt="none",linefmt="r--", 
             markerfmt="rx",basefmt="none",label="With replacement");
    else
        stem(0:numberFished,proportions,basefmt="none",label="Without replacement")
    end
end

N = 10^6
goldFish, silverFish, numberFished = 3, 4, 3

figure(figsize=(5,5))
proportionFished(goldFish, silverFish, numberFished, N)
proportionFished(goldFish, silverFish, numberFished, N, true)
ylim(0,0.7)
xlabel(L"$n$")
ylabel("Probability")
legend(loc="upper left")
savefig("fishing.png");

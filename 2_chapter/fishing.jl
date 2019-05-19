using StatsBase, PyPlot

function proportionFished(gF,sF,numberFished,N,withReplacement = false)
    function fishing()
        fishInPond = [ones(Int64,gF); zeros(Int64,sF)]
        fishCaught = Int64[]

        for fish in 1:numberFished
            fished = rand(fishInPond)
            push!(fishCaught,fished)
            if withReplacement == false
                deleteat!(fishInPond, findfirst(x->x==fished, fishInPond))
            end
        end
        sum(fishCaught)
    end

    simulations = [fishing() for _ in 1:N]
    proportions = counts(simulations,0:numberFished)/N

    if withReplacement
        stem(0:numberFished,proportions,basefmt="none",linefmt="r--",
             markerfmt="rx",label="With replacement")
    else
        stem(0:numberFished,proportions,basefmt="none",
			label="Without replacement")
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

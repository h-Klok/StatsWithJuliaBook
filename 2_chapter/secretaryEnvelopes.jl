using PyPlot,StatsBase

function proportionCorrect(letters,n)

    function envelopeStuffer()
        envelopes = shuffle!(collect(1:letters))
        sum([envelopes[i] == i for i in 1:letters])
    end

    data = [envelopeStuffer() for _ in 1:n]
    proportions = counts(data,0:letters)/n
    stem(0:letters,proportions,basefmt="none",label="Simulated results")
    plot(0,1/e,"rx",label="Limiting asymptote 1/e",markersize=8)
    println("Analytic solution: ", 1 -sum([(-1)^(k+1)/factorial(k)
                                    for k in 1:letters]))
    println("Simulation: ", proportions[1])
    println("Limiting asymptoe: ",1/e)
end

proportionCorrect(4, 10^6)
ylim(0,0.4)
xlabel("Number of correct envelopes")
ylabel("Proportion")
legend(loc="upper right")
savefig("secretaryEnvelopes.png");

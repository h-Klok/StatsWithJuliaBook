using StatsBase,PyPlot

matchExists(n) = 1 - (364/365)^(n*(n-1)/2)

function bdEvent(n)
    birthdays = rand(1:365,n)
    dayCounts = counts(birthdays, 1:365)
    return maximum(dayCounts) > 1
end

probEst(n) = sum([bdEvent(n) for i in 1:N])/N

xGrid, N = 1:50, 10^4
analyticSolution = [matchExists(n) for n in xGrid]
mcEstimates = [probEst(n) for n in xGrid]

plot(xGrid,analyticSolution,".", label="Analytic solution")
plot(xGrid,mcEstimates,"rx",label="Numerical estimate")
xlabel(L"$n$")
ylabel("Probability")
legend(loc="upper left")
savefig("birthdayProblem.png")

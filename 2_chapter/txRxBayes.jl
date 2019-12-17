using Random
Random.seed!(1)

N = 10^5
prob1 = 0.7
eps0, eps1 = 0.1, 0.05

flipWithProb(bit,prob) = rand() < prob ? xor(bit,1) : bit

TxData = rand(N) .< prob1
RxData = [x == 0 ? flipWithProb(x,eps0) : flipWithProb(x,eps1) for x in TxData]

numTx1 = 0
totalRx1 = 0
for i in 1:N
   if RxData[i] == 1
        global totalRx1 += 1
        global numTx1 += TxData[i]
    end
end

monteCarlo = numTx1/totalRx1
analytic = ((1-eps1)*0.7)/((1-eps1)*0.7+0.3*eps0)

println("Monte Carlo: ", monteCarlo, "\t\tAnalytic: ", analytic)

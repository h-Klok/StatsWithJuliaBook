using Random
Random.seed!(1)

N = 10^5
prob1 = 0.7
eps0 = 0.1
eps1 = 0.05

function flipWithProb(bit,prob)
   return rand() < prob ? xor(bit,1) : bit
end

TxData = rand(N) .< prob1
RxData = [x == 0 ? flipWithProb(x,eps0) : flipWithProb(x,eps1) for x in TxData]

numRx1 = 0
totalRx1 = 0
for i in 1:N
   if RxData[i] == 1
        totalRx1 += 1
        numRx1 += TxData[i]
    end
end

numRx1/totalRx1, ((1-eps1)*0.7)/((1-eps1)*0.7+0.3*eps0)

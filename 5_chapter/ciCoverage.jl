using Random, Distributions, PyPlot
Random.seed!(2)

mu = 5.57
alpha  = 0.05
L(obs) = obs - (1-sqrt(alpha))
U(obs) = obs + (1-sqrt(alpha))

tDist = TriangularDist(mu-1,mu+1,mu)
N = 100

for k in 1:N
    observation = rand(tDist)
    LL,UU = L(observation), U(observation)
    plt.bar(k,bottom = LL,UU-LL,color= (LL < mu && mu < UU) ? "b" : "r")
end

plot([0,N+1],[mu,mu],c="k",label="Parameter value")
legend(loc="upper right")
ylabel("Value")
xticks([])
xlim(0,N+1)
ylim(3,8)

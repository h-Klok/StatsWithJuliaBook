using PyPlot

a, c, d = 2, 1, 5
next(x,y) = [a*x*(1-x) - x*y, -c*y + d*x*y]
equibPoint = [(1+c)/d ,(d*(a-1)-a*(1+c))/d]

initX = [0.8,0.05]
tEnd = 100

traj = [[] for _ in 1:tEnd]
traj[1] = initX

for t in 2:tEnd
    traj[t] = next(traj[t-1]...)
end

plot(first.(traj),last.(traj),"b.--",label="Model trajectory")
plot(traj[1][1], traj[1][2], "k.", ms=15, label="Initial state")
plot(equibPoint[1],equibPoint[2],"r+",mew="4",ms="10",label="Equlibrium point")
xlabel("X1"); ylabel("X2"); legend(loc="upper right")

using PyPlot

a, c, d = 2, 1, 5
next(x,y) = [a*x*(1-x) - x*y, -c*y + d*x*y]
equibPoint = [(1+c)/d ,(d*(a-1)-a*(1+c))/d] 

initX = [0.8,0.05]
tEnd = 100;

traj = [[] for _ in 1:tEnd]
traj[1] = initX

for t in 2:tEnd
    traj[t] = next(traj[t-1]...)
end

plot(first.(traj),last.(traj),"k--")
plot(first.(traj),last.(traj),"r.")
plot(equibPoint[1],equibPoint[2],"g.",ms="10")
xlabel("X"); ylabel("Y")
xlim(0,1);ylim(0,0.3);
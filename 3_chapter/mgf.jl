using Distributions, PyPlot

dist1 = TriangularDist(0,1,1)
dist2 = TriangularDist(0,1,0)
N=10^6

data1, data2 = rand(dist1,N),rand(dist2,N)
dataSum = data1 + data2

figure(figsize=(10,5))
subplots_adjust(wspace=0.3)

subplot(121)
p2 = plt.hist(dataSum,200,normed="true")
xlabel("x")
ylabel("PDF")

sGrid = -1:0.01:1
mgf(s) = 4(1+(s-1)*MathConstants.e^s)*(MathConstants.e^s-1-s)/s^4

function mgfEst(s)
    N = 20
    data1, data2 = rand(dist1,N),rand(dist2,N)
    dataSum = data1 + data2
    sum([MathConstants.e^(s*x) for x in dataSum])/length(dataSum)
end

subplot(122)
plot(sGrid,mgfEst.(sGrid),"b")
plot(sGrid,mgf.(sGrid),"r")
plot([minimum(sGrid),maximum(sGrid)],[minimum(sGrid),maximum(sGrid)].+1,"k")
xlabel("s")
ylabel("MGF")

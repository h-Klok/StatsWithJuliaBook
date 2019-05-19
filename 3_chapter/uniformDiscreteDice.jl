using StatsBase, PyPlot

faces, N = 1:6, 10^6
mcEstimate = counts(rand(faces,N), faces)/N
stem(faces,mcEstimate,basefmt="none",label="MC estimate")
plot([i for i in faces],[1/6 for _ in faces],"rx",label="PMF")
xlabel("Face number")
ylabel("Probability")
ylim(0,0.2)
legend(loc="upper right")

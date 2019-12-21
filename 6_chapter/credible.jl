using Distributions, Plots, LaTeXStrings; pyplot()

alpha, beta = 8, 2
data = [2,1,0,0,1,0,2,2,5,2,4,0,3,2,5,0]

newAlpha, newBeta = alpha + sum(data), beta + length(data)
post = Gamma(newAlpha, 1/newBeta)

xGrid = quantile(post,0.01):0.001:quantile(post,0.99)
significance = 0.9; halfAlpha = (1-significance)/2

coverage(l,u) = cdf(post,u) - cdf(post,l)

function classicalCI(dist)
    l, u = mode(dist),mode(dist)
    bestl, bestu = l, u
    while  coverage(l,u) < significance 
        l -= 0.00001; u += 0.00001
    end
    (l,u)
end
equalTailCI(dist) = (quantile(dist,halfAlpha), quantile(dist,1-halfAlpha))
function highestDensityCI(dist)
    height = 0.999 * maximum(pdf.(dist,xGrid))
    l,u = mode(dist),mode(dist)
    while coverage(l,u) <= significance
        range = filter(theta -> pdf(dist,theta) > height, xGrid)
        l,u = minimum(range), maximum(range)
        height -= 0.00001
    end
    (l,u)
end

l1, u1 = classicalCI(post)
l2, u2 = equalTailCI(post)
l3, u3 = highestDensityCI(post)
println("Classical: ", (l1,u1), "\tWidth: ",u1-l1, 
	"\tCoverage: ", coverage(l1,u1))
println("Equal tails: ", (l2,u2), "\tWidth: ",u2-l2, 
	"\tCoverage: ", coverage(l2,u2))
println("Highest density: ", (l3,u3), "\tWidth: ",u3-l3, 
	"\tCoverage: ", coverage(l3,u3))

plot(xGrid,pdf.(post,xGrid),  yticks=(0:0.25:1.25),
	c=:black, label="Gamma Posterior Distribution",
    	xlims=(1.4, 2.9), ylims=(-0.4,1.25))
plot!([l1,u1],[-0.1,-0.1], label="Classic CI", 
    	c=:blue, shape=:vline, ms=16)
plot!([l2,u2],[-0.2,-0.2], label="Equal Tail CI", 
    	c=:red, shape=:vline, ms=16)
plot!([l3,u3],[-0.3,-0.3], label="Highest Density CI", 
	c=:green, shape=:vline, ms=16, xlabel=L"\lambda", ylabel="Density")
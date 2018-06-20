using PyPlot, Roots

function polynomialGenerator{T<:Real}(a::T...)
    n = length(a)-1
    poly =  function(x) 
                return sum([a[i+1]*x^i for i in 0:n])
            end
    return poly 
end

polynomial = polynomialGenerator(-10,3,1)
zeroVals = fzeros(polynomial,-10,10)
println("Zeros of the function f(x): ", zeroVals)

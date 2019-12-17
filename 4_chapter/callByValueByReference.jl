f(z::Int) = begin z = 0 end
f(z::Array{Int}) = begin z[1] = 0 end

x = 1
@show typeof(x)
@show isimmutable(x)
println("Before call by value: ", x)
f(x)
println("After call by value: ", x,"\n")

x = [1]
@show typeof(x)
@show isimmutable(x)
println("Before call by reference: ", x)
f(x)
println("After call by reference: ", x)
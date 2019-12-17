array1 = [(2n+1)^2 for n in 1:5]
array2 = [sqrt(i) for i in array1]
println(typeof(1:5), "  ", typeof(array1), "  ", typeof(array2))
1:5, array1, array2
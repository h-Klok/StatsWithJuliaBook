setA = Set{Int64}([1,2,2,3])
setB = Set{Int64}(2:6)

uAB = union(setA, setB)
iAB = intersect(setA, setB)
diffAB = setdiff(setA,setB)

println("A union B = $uAB \nA intersect B = $iAB \nA diff B = $diffAB") 
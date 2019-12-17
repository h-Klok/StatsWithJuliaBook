println("Immutable:")
a = 10
b = a
b = 20
@show a

println("\nNo copy:")
a = [10]
b = a
b[1] = 20
@show a

println("\nCopy:")
a = [10]
b = copy(a)
b[1] = 20
@show a

println("\nShallow copy:")
a = [[10]]
b = copy(a)
b[1][1] = 20
@show a

println("\nDeep copy:")
a = [[10]]
b = deepcopy(a)
b[1][1] = 20
@show a;
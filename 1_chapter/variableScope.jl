data = [1,2,3]
s = 0
beta, gamma = 2, 1

for i in 1:length(data)
    print(i," ")
    global s    #This usage of the `global` keyword is not needed in Jupyter
                #But elsewhere without it:
                #ERROR: LoadError: UndefVarError: s not defined
    s += beta*data[i]
    data[i] *= -1
end
# print(i)       #Would cause ERROR: LoadError: UndefVarError: i not defined
println("\nSum of data in external scope: ", s)

function sumData(beta)
    s = 0           #try adding the prefix global
    for i in 1:length(data)
        s += data[i] + gamma
    end
    return s
end
println("Sum of data in a function: ", sumData(beta/2))
@show s

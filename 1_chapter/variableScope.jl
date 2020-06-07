
s = 0
for i in 1:5
    global s += i #This usage of the `global` keyword is not needed in Jupyter
                  #But elsewhere without it:
                  #ERROR: LoadError: UndefVarError: s not defined    
end
println("Fifteen: ", s)

function fiftyFive()
    s = 0
    for i in 1:10
        s += i
    end
    s
end
println("FiftyFive: ", fiftyFive())

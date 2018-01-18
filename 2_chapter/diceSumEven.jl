n, faces = 10^6, 1:6

numSol = sum([iseven(i+j) for i in faces, j in faces])/36
mcEst = sum([iseven(rand(faces)+rand(faces)) for i in 1:n]) / n

println("Numerical solution = $numSol \nMonte Carlo estimate = $numSol")

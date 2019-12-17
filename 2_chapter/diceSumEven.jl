N, faces = 10^6, 1:6

numSol = sum([iseven(i+j) for i in faces, j in faces]) / length(faces)^2
mcEst  = sum([iseven(rand(faces) + rand(faces)) for i in 1:N]) / N

println("Numerical solution = $numSol \nMonte Carlo estimate = $mcEst")

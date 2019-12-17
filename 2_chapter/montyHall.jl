using Random
Random.seed!(1)

function montyHall(switchPolicy)
    prize, choice = rand(1:3), rand(1:3)
    if prize == choice
        revealed = rand(setdiff(1:3,choice))
    else
        revealed = rand(setdiff(1:3,[prize,choice]))
    end

    if switchPolicy
        choice = setdiff(1:3,[revealed,choice])[1]
    end
    return choice == prize
end

N = 10^6
println("Success probability with policy I (stay): ", 
	sum([montyHall(false) for _ in 1:N])/N)
println("Success probability with policy II (switch): ", 
	sum([montyHall(true) for _ in 1:N])/N)
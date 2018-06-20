numbers = 10:25
N = 10^7

firstDigit(x) = Int(floor(x/10))
secondDigit(x) = x%10
    
numThirteen,numFirstIsOne,numSecondIsThree = 0,0,0

for _ in 1:N
    X = rand(numbers)
    numThirteen += X == 13 ? 1 : 0
    numFirstIsOne += firstDigit(X) == 1 ? 1 : 0
    numSecondIsThree += secondDigit(X) == 3 ? 1 : 0 
end

probThirteen, probFirstIsOne, probSecondIsThree =
    (numThirteen,numFirstIsOne,numSecondIsThree)./N

println("P(13) = ", round(probThirteen,4),
        "\n", "P(1_) = ",round(probFirstIsOne,4),
        "\t","P(_3) = ", round(probSecondIsThree,4),
 	"\n", "P(1_)*P(_3) = ",round(probFirstIsOne*probSecondIsThree,4))

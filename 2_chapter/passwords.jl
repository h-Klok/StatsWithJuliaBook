numLowerCaseChars(str) = sum([islower(char) for char in str])

passLength, numToCheck = 8, 1
possibleChars = ['a':'z';'A':'Z';'0':'9']

n = 10^6
passwords = [String(rand(possibleChars,passLength)) for _ in 1:n]
proportion = sum([numLowerCaseChars(p) <= numToCheck for p in passwords])/n
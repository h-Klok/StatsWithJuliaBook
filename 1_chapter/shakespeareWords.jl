using Requests, JSON

file = get("https://ocw.mit.edu/ans7870/6/6.006/s08/lecturenotes/files/
            t8.shakespeare.txt")
shakespeare = String(file.data)
shakespeareWords = split(shakespeare)

jsonWords = String(get("https://courses.smp.uq.edu.au/STAT2201/2017a/
                        parseCommand.json").data)
parsedJsonDict = JSON.parse(jsonWords)
keywords = Array{String}(parsedJsonDict["words"])
numberToShow = parsedJsonDict["numToShow"]

wordCount = Dict([(x,count(w -> lowercase(w) == lowercase(x), shakespeareWords))
                  for x in keywords])
sortedWordCount = sort(collect(wordCount),by=last,rev=true)
sortedWordCount[1:numberToShow]

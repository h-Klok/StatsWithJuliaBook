function lineSearch(inputFilename, outputFilename, keyword)
	infile = open(inputFilename, "r")
	outfile = open(outputFilename,"w")

	for (index, text) in enumerate(eachline(infile))
		if contains(text, keyword)
			println(outfile, "$index: $text")
		end
	end
	close(infile)
	close(outfile)
end

lineSearch("earth.txt", "waterLines.txt", "water")

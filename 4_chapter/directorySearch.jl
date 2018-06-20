function directorySearch(directory, searchString)
	outfile = open("fileList.txt","w")
	fileList = filter(x->contains(x,searchString), readdir(directory))

	for file in fileList
		println(outfile, file) 
	end
	close(outfile)
end

directorySearch(pwd(),".png")

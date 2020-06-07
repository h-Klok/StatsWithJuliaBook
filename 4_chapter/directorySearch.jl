function directorySearch(directory, searchString)
    outfile  = open("../data/fileList.txt","w")
    fileList = filter(x->occursin(searchString, x), readdir(directory))

    for file in fileList
        println(outfile, file)
    end
    close(outfile)
end

directorySearch(pwd(),".jl")

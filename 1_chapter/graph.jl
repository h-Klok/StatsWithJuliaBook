using PyPlot, PyCall
@pyimport matplotlib.animation as anim
@pyimport matplotlib.lines as line

function graphCreator(n::Int)
    vertices = 1:n
    complexPts = [exp(im*2*pi*k/n) for k in vertices]
    coords = [(real(p),imag(p)) for p in complexPts]
    xPts = first.(coords)
    yPts = last.(coords)
    edges = []
    for v in vertices
         [ push!(edges,(v,u)) for u in (v+1):n ]
    end

    fig = figure(figsize=(8,8))
    ax = axes(xlim = (-1.5,1.5),ylim=(-1.5,1.5), aspect=1)
    dots = line.Line2D(xPts, yPts, ls="None", marker="o",ms=20, mec="blue",
                          mfc="blue")
    ax[:add_artist](dots)

    function animate(i)
        u, v = edges[i][1], edges[i][2]
        xpoints = (xPts[u],xPts[v])
        ypoints = (yPts[u],yPts[v])
        ax[:plot](xpoints,ypoints,"r-")
    end

	[animate(i) for i in 1:length(edges)]
	
end

graphCreator(16);

using PyPlot, PyCall
anim = pyimport("matplotlib.animation")
line = pyimport("matplotlib.lines")

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

    fig, ax = subplots()
    xlim(-1.5,1.5)
    ylim(-1.5,1.5)
    dots = line.Line2D(xPts, yPts, ls="None", marker="o",ms=20, mec="blue",
                          mfc="blue")
    ax.add_artist(dots)

    function animate(i)
        u, v = edges[i][1], edges[i][2]
        xpoints = (xPts[u],xPts[v])
        ypoints = (yPts[u],yPts[v])
        ax.plot(xpoints,ypoints,"r-")
    end

	ani = [animate(i) for i in 1:length(edges)]
	anim.ArtistAnimation(fig, ani, interval=5, blit="False", repeat_delay=10)
end

graphCreator(16)

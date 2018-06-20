using PyPlot, PyCall 
@pyimport matplotlib.image as mpimg
@pyimport matplotlib.patches as patch

img = mpimg.imread("stars.png") 
bwImg = img[:,:,1]*0.299 +img[:,:,2]*0.587 + img[:,:,3]*0.114
sizeX,sizeY = size(bwImg)

function filter(image,x,y,d)
    if x<=d || y<=d || x>=sizeX-d || y>=sizeY-d
        return image[x,y]
    else
        total = 0.0
        for xi = x-d:x+d
            for yi = y-d:y+d
                total += image[xi,yi]
            end
        end
        return total/((2d+1)^2)
    end
end
    
smoothedImage = [filter(bwImg,x,y,10) for x in 1:sizeX, y in 1:sizeY]
yUnclean, xUnclean = ind2sub(bwImg,findmax(bwImg)[2])
yClean, xClean = ind2sub(smoothedImage,findmax(smoothedImage)[2])

fig = figure(figsize=(10,5))
subplot(121)
axOriginal = fig[:add_subplot](1,2,1)
axOriginal[:imshow](bwImg,cmap="Greys")
axOriginal[:add_artist](patch.Circle([xUnclean,yUnclean],20,fc="none",ec="red",lw=3));

subplot(122)
axSmoothed = fig[:add_subplot](1,2,2)
axSmoothed[:imshow](smoothedImage,cmap="Greys")
axSmoothed[:add_artist](patch.Circle([xClean,yClean],20,fc="none",ec="red",lw=3));
savefig("imageProcessing.pdf")
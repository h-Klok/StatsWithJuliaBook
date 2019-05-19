using PyPlot, PyCall
image = pyimport("matplotlib.image")
patch = pyimport("matplotlib.patches")

img = image.imread("stars.png")
gImg = img[:,:,1]*0.299 +img[:,:,2]*0.587 + img[:,:,3]*0.114
rows, cols = size(gImg)

function boxBlur(image,x,y,d)
    if x<=d || y<=d || x>=cols-d || y>=rows-d
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

blurImg = [boxBlur(gImg,x,y,3) for x in 1:cols, y in 1:rows]

yOriginal, xOriginal = argmax(gImg).I
yBoxBlur, xBoxBlur   = argmax(blurImg).I

fig, (axO, axS)= subplots(1,2,figsize=(10,5))
axO.imshow(gImg,cmap="Greys")
axO.add_artist(patch.Circle([xOriginal,yOriginal],20,fc="none",ec="red",lw=3))

axS.imshow(blurImg,cmap="Greys")
axS.add_artist(patch.Circle([xBoxBlur,yBoxBlur],20,fc="none",ec="red",lw=3))

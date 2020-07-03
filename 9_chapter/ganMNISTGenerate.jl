using Flux, BSON, Random, Plots; pyplot()
Random.seed!(0)

latentDim = 100
outputX, outputY = 6, 3

gen =  Chain(Dense(latentDim,7*7*256),BatchNorm(7*7*256,relu),
        x->reshape(x,7,7,256,:),ConvTranspose((5,5),256=>128;stride=1,pad=2),
        BatchNorm(128,relu),ConvTranspose((4,4),128=>64;stride=2,pad=1),
        BatchNorm(64,relu),ConvTranspose((4,4),64=>1,tanh;stride=2,pad=1))

cd(@__DIR__)
BSON.@load "../data/mnistGAN40.bson" genParams
Flux.loadparams!(gen, genParams)

fixedNoise = [randn(latentDim, 1) for _ in 1:outputX*outputY]
fakeImages = @. gen(fixedNoise)
imageArray = permutedims(dropdims(reduce(vcat,
            reduce.(hcat, Iterators.partition(fakeImages, outputY)));
             dims=(3, 4)), (2, 1))

heatmap(imageArray, yflip = true, color = :Greys,
        size = (300,150), legend=false, ticks=false)
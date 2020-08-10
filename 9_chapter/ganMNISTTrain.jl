using Flux, MLDatasets, Statistics, Random, BSON
using Flux.Optimise: update!
using Flux: logitbinarycrossentropy

batchSize, latentDim = 500, 100
epochs = 40
etaD, etaG = 0.0002, 0.0002

images, _ = MLDatasets.MNIST.traindata(Float32)
imageTensor = reshape(@.(2f0 * images - 1f0), 28, 28, 1, :)
data = [imageTensor[:, :, :, r] for r in Iterators.partition(1:60000, batchSize)]

dscr = Chain(Conv((4,4),1=>64;stride=2,pad=1),x->leakyrelu.(x,0.2f0),
        Dropout(0.25),Conv((4,4),64=>128;stride=2,pad=1),x->leakyrelu.(x,0.2f0),
        Dropout(0.25), x->reshape(x, 7 * 7 * 128, :), Dense(7 * 7 * 128, 1))
gen =  Chain(Dense(latentDim,7*7*256),BatchNorm(7*7*256,relu),
        x->reshape(x,7,7,256,:),ConvTranspose((5,5),256=>128;stride=1,pad=2),
        BatchNorm(128,relu),ConvTranspose((4,4),128=>64;stride=2,pad=1),
        BatchNorm(64,relu),ConvTranspose((4,4),64=>1,tanh;stride=2,pad=1))

dLoss(realOut,fakeOut) =    mean(logitbinarycrossentropy.(realOut,1f0)) +
                            mean(logitbinarycrossentropy.(fakeOut,0f0))
gLoss(u) = mean(logitbinarycrossentropy.(u, 1f0))

function updateD!(gen, dscr, x, opt_dscr)
    noise = randn!(similar(x, (latentDim, batchSize)))
    fakeInput = gen(noise)
    ps = Flux.params(dscr)
    loss, back = Flux.pullback(()->dLoss(dscr(x), dscr(fakeInput)), ps)
    grad = back(1f0)
    update!(opt_dscr, ps, grad)
    return loss
end

function updateG!(gen, dscr, x, optGen)
    noise = randn!(similar(x, (latentDim, batchSize)))
    ps = Flux.params(gen)
    loss, back = Flux.pullback(()->gLoss(dscr(gen(noise))),ps)
    grad = back(1f0)
    update!(optGen, ps, grad)
    return loss
end

optDscr, optGen = ADAM(etaD), ADAM(etaG)
cd(@__DIR__)
@time begin
    for ep in 1:epochs
        for (bi,x) in enumerate(data)
            lossD = updateD!(gen, dscr, x, optDscr)
            lossG = updateG!(gen, dscr, x, optGen)
            @info "Epoch $ep, batch $bi, D loss = $(lossD), G loss = $(lossG)"
        end
        @info "Saving generator for epcoh $ep"
        BSON.@save "../data/mnistGAN$(ep).bson" genParams=cpu.(params(gen))
    end
end

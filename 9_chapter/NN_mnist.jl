using Flux, Flux.Data.MNIST, Random, Statistics, PyPlot
using Flux: onehotbatch, onecold, crossentropy, throttle, @epochs
using Base.Iterators: repeated, partition
Random.seed!(1)

imgs   = MNIST.images()
labels = onehotbatch(MNIST.labels(), 0:9)

train  = [(cat(float.(imgs[i])..., dims = 4), labels[:,i])
		for i in partition(1:50000, 1000)]
test   = [(cat(float.(imgs[i])..., dims = 4), labels[:,i])
		for i in partition(50001:60000, 1000)]

m = Chain(
  Conv((5,5), 1=>8, relu),
  x -> maxpool(x, (2,2)),
  Conv((3,3), 8=>16, relu),
  x -> maxpool(x, (2,2)),
  x -> reshape(x, :, size(x, 4)),
  Dense(400, 10), softmax)

loss(x, y) = crossentropy(m(x), y)
accuracy(x, y) = mean(onecold(m(x)) .== onecold(y))
opt = ADAM(params(m))

L, A = [], []
evalcb = throttle(10) do
    push!( L, mean( [ loss( test[i][1],  test[i][2] ).data for i in 1:10] ) )
    push!( A, mean( [ accuracy( test[i][1],  test[i][2] ) for i in 1:10] ) )
end

@epochs 3 Flux.train!(loss, train, opt, cb=evalcb)

plot( 1:length(L) , L, label="loss function","bo-")
plot( 1:length(A) , A, label="accuracy","ro-")

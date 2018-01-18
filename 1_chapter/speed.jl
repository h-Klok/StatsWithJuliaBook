### Julia
tic()
[mean(randn(100)) for _ in 1:10^6]
toc()

### Mathematica (to fix up
t = AbsoluteTime[];
data = Table[Mean[RandomVariate[NormalDistribution[], 100]], {1000000}];
Histogram[data, {"Raw", 100}]
AbsoluteTime[] - t

### Matlab (to fix up)
tic;
for k=1:1000000;A(k)=mean(randn(100,1));end
hist(A,100);
toc;

### R code
start <- Sys.time ()
replicate(10^6,mean(rnorm(100)))
Sys.time () - start

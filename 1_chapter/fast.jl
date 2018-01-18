@time begin
	[mean(randn(100)) for _ in 1:10^6]
end;

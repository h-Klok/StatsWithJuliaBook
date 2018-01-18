@time begin
	data = Float64[]
	for i in 1:10^6
		group = Float64[]
		for j in 1:10^2
			push!(group,randn())
		end
		push!(data,mean(group))
	end
end;

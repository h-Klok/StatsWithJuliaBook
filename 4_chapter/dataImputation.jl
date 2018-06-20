include("dataSummary.jl")
purchaseData[isna.(purchaseData[:Name]), :Name] = "missing" 
purchaseData[isna.(purchaseData[:Time]), :Time] = "12:00 PM" 

missingType = find(isna.(purchaseData[:, :Type]))
missingPrice = find(isna.(purchaseData[:, :Price]))
X = Int64[]
for i in missingType
     (i in missingPrice) ? push!(X,i) : next
end

types = unique(dropna(purchaseData[:Type])) 
for i in missingType
    isna(purchaseData[:Type][i]) ? purchaseData[:Type][i] = rand(types) : next  
end

deleterows!(purchaseData, X)

avgPrice = Int(round(mean(dropna(purchaseData[:Price])))) 
purchaseData[isna.(purchaseData[:Price]), :Price] = avgPrice

showcols(purchaseData)

using DataFrames, PyPlot

df = readtable("workplaceAttributes.csv")

n = size(df)[1]
dTheta = 2pi/n
theta = [0:dTheta:2pi;]

attributes = df[1]

fig = figure("pyplot_windrose_lineplot",figsize=(10,10)) # Create a new figure
ax = axes(polar="true") # Create a polar axis

for i in 2:4
	data = df[names(df)[i]]/100
	data = [data;data[1]]
	plot(theta,data,linestyle="-", label=names(df)[i], marker="None") # Basic line plot
end

title("Workplace attribute ratings\n (higher is better)\n")
legend(loc="upper right")
ax[:set_xticklabels](attributes,rotation_mode="anchor")
ax[:set_thetagrids]([0:dTheta*360/(2pi):360-n;],frac=1.1) # Show grid lines from 0 to 360 in increments 
ax[:set_theta_zero_location]("N") # Set 0 degrees to the top of the plot
ax[:set_theta_direction](-1) # Switch to clockwise
fig[:canvas][:draw]() # Update the figure
savefig("radarPlot.png")

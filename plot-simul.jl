using CairoMakie

n = 1000 # number of pionts
pts = rand(2, n) .* 2 .- 1 # random 2-dimensional points in the [-1, 1] interval

in_out_flag = zeros(Bool, n)
for i = 1:size(pts, 2)
    in_out_flag[i] = pts[1, i]^2 + pts[2, i]^2 < 1
end

# initialize figure
f = Figure()
f1 = Axis(f[1, 1], aspect = DataAspect())
# shape decomposition
poly!(Circle(Point2f(0, 0), 1), color = RGBAf(0, 0, 0, 0.1), strokecolor = :black, strokewidth = 2)
# add points
scatter!(pts[1, in_out_flag], pts[2, in_out_flag], markersize = 5, color = "forestgreen")
scatter!(pts[1, .!in_out_flag], pts[2, .!in_out_flag], markersize = 5, color = "brown3")
# current_figure()


isdir("assets") || mkdir("assets")
ENV["RESULTS_FILE"] = "assets/simul-pi.png"

save("assets/simul-pi.svg", f)
save("assets/simul-pi.png", f)
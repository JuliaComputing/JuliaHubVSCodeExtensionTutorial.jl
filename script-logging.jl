using JuliaHubVSCodeExtensionTutorial
using JSON3

n = 10 .^ (3:9)

stats_list = []

for i in 1:length(n)
    stats = @timed estimate_pi_single(n[i])
    @info "progress logging:" i n[i] stats[:value]
    push!(stats_list, stats)
end

results = Dict(
    :pi => stats_list[end][:value],
    :num_trials => n[end],
    :compute_time => stats_list[end][:time]
)

open("results.json", "w") do io
    JSON3.pretty(io, results)
end

ENV["RESULTS"] = JSON3.write(results)
ENV["RESULTS_FILE"] = "results.json"
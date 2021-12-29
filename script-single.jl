using JuliaHubVSCodeExtensionTutorial
using JSON3

n = 1_000_000_000

stats = @timed begin
    estimate_pi_single(n)
end

@info "Finished computation. π estimate: " stats[:value]

results = Dict(
    :pi => stats[:value],
    :num_trials => n,
    :compute_time => stats[:time]
)

open("results.json", "w") do io
    JSON3.pretty(io, results)
end

ENV["RESULTS"] = JSON3.write(results)
ENV["RESULTS_FILE"] = "results.json"
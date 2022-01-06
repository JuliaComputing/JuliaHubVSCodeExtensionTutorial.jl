using JuliaHubVSCodeExtensionTutorial, JSON3, Distributed

n = parse(Int64, replace(get(ENV, "n", "10_000_000_000"), '_' => ""))

stats = @timed begin
    estimate_pi_distributed(n)
end

@info "Finished computation. π estimate: " stats[:value]

results = Dict(
    :pi => stats[:value],
    :num_trials => n,
    :compute_time => stats[:time],
    :workers => nworkers()
)

open("results.json", "w") do io
    JSON3.pretty(io, results)
end

ENV["RESULTS"] = JSON3.write(results)
ENV["RESULTS_FILE"] = "results.json"
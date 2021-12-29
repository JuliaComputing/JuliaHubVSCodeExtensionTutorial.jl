using JuliaHubVSCodeExtensionTutorial
using JSON3
using Tar

n = 1_000_000_000

path_results = "$(@__DIR__)/results"
mkdir(path_results)

stats = @timed begin
    estimate_pi_single(n)
end

@info "Finished computation. π estimate: " stats[:value]

results = Dict(
    :pi => stats[:value],
    :num_trials => n,
    :compute_time => stats[:time]
)

open("$(path_results)/results.json", "w") do io
    JSON3.pretty(io, results)
end

tarball = Tar.create(path_results)

ENV["RESULTS"] = JSON3.write(results)
ENV["RESULTS_FILE"] = tarball
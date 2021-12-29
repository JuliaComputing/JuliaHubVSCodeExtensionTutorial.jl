module JuliaHubVSCodeExtensionTutorial

using Distributed

export estimate_pi_single, estimate_pi_distributed

function estimate_pi_single(n)
    n > 0 || throw(ArgumentError("number of iterations must be > 0, got $n"))
    incircle = 0
    for i = 1:n
        x, y = rand() * 2 - 1, rand() * 2 - 1
        if x^2 + y^2 <= 1
            incircle += 1
        end
    end
    return 4 * incircle / n
end

function estimate_pi_distributed(n)
    n > 0 || throw(ArgumentError("number of iterations must be > 0, got $n"))
    incircle = @distributed (+) for i in 1:n
        x, y = rand() * 2 - 1, rand() * 2 - 1
        Int(x^2 + y^2 <= 1)
    end
    return 4 * incircle / n
end
end # module

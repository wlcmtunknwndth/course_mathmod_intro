using Plots
using DifferentialEquations

N = 963
n0 = 12

alpha = 0.00001
beta = 0.35

function ode(du, u, p, t)
    du[1] = (alpha + beta * u[1]) * (N - u[1])
end

t_arr = (0, 0.1)
problem = ODEProblem(ode, [n0], t_arr)
solution = solve(problem, dtmax = 0.01)

n = [u[1] for u in solution.u]
T = [t for t in solution.t]


function findmax_dn(T, sol)
    max_dn = 0
    max_t = 0
    max_n = 0

    for (i, t) in enumerate(T)
        if sol(t, Val{1})[1] > max_dn
            max_dn = sol(t, Val{1})[1]
            max_t = t
            max_n = n[i]
        end
    end
    return max_dn, max_t, max_n
end    

max_dn, max_t, max_n = findmax_dn(T, solution)

plt = plot(
    dpi = 500, 
    title = "Advertisement efficiency",
    xlabel = "time",
    ylabel = "people know",
    legend = true
)

plot!(
    plt,
    T,
    n,
    label = "Spreading",
    color = :green
)

plot!(
    plt,
    [max_t],
    [max_n],
    seriestype = :scatter,
    label = "Maximum popularity growth",
    color = :black
)

savefig(plt, "./lab7/image/lab7_2.png")
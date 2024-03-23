using Plots
using DifferentialEquations

N = 963
n0 = 12


alpha = 0.68
beta = 0.00018

function ode(du, u, p, t)
    du[1] = (alpha + beta*u[1]) * (N - u[1])
    
end

t_arr = (0, 30)
problem = ODEProblem(ode, [n0], t_arr)

solution = solve(problem, dtmax = 0.05)

n = [u[1] for u in solution.u]
T = [t for t in solution.t]

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
    label = "efficiency",
    color = :green
)

savefig(plt, "./lab7/image/lab7_1.png")
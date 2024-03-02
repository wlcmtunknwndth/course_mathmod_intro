using DifferentialEquations
using Plots

w = 1
g = 0.6
x0 = 0.8
y0 = -1
t = (0,62)
function ode(du, u, p, t)
    du[1]  = u[2]
    du[2]  = cos(1.5*t) - w * u[1] - g*u[2]
end

problem = ODEProblem(ode, [x0, y0], t)

sol = solve(problem, dtmax = 0.05)

plt = plot(
    layout = (1, 2)
)

t_arr = [t for t in sol.t]
sol_x = [u[1] for u in sol.u]

plot!(
    plt[1],
    t_arr,
    sol_x,
    color = :red,
    title = "solution",
    label = "x(t)"
)

plot!(
    plt[2],
    sol_x,
    [u[2] for u in sol.u],
    color = :black,
    title = "phase portrait",
    label = "y(x)"
)

savefig(plt, "./lab4/task3.png")
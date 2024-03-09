using Plots
using DifferentialEquations

a = 0.45
b = 0.046

c = 0.47
d = 0.048

x0 = c/d
y0 = a/b

function df(du, u, p, t)
    du[1] = -a * u[1] + b * u[1] * u[2]
    du[2] = c * u[2] - d * u[1] * u[2]    
end

interval = (0, 50)

initial = [x0, y0]

problem = ODEProblem(df, initial, interval)

solution = solve(problem, dtmax=0.05)

x_arr = [u[1] for u in solution.u]
y_arr = [u[2] for u in solution.u]
t_arr = [t for t in solution.t]

plt1 = plot(
    dpi = 600,
    legend = true,
    title = "Стационарное состояние хищник-жертва"
)

plot!(
    plt1,
    t_arr,
    x_arr,
    label = "Численность жертв",
    xlabel = "время",
    ylabel = "численность",
    color = :black
)

plot!(
    plt1,
    t_arr,
    y_arr,
    label = "Численность хищников",
    color = :blue    
)

savefig(plt1, "./lab5/image/1_3.png")
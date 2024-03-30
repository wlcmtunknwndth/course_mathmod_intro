using Plots
using DifferentialEquations

M1 = 7.1
M2 = 8.1
p_cr = 44
N = 77
q = 1
tau1 = 26
tau2=21
p1= 11
p2 = 8.7

a1 = p_cr / (tau1^2 * p1^2 * N * q)
a2 = p_cr / (tau2^2 * p2^2 * N * q)
b = p_cr / (tau1^2 * tau2^2 * p1^2 * p2^2 * N * q)
c1 = (p_cr - p1) / (tau1 * p1)
c2 = (p_cr - p2) / (tau2 * p2)

function ode(du, u, p, t)
    du[1] = u[1] - b/c1*u[1] * u[2] - a1/c1*u[1]^2
    du[2] = c2/c1*u[2] - b / c1 * u[1] * u[2] - a2 / c1*u[2]^2
end

t_arr = (0, 50)
prob = ODEProblem(ode, [M1, M2], t_arr)
sol = solve(prob, dtmax = 0.05)

ans1 = [u[1] for u in sol.u]
ans2 = [u[2] for u in sol.u]
t = [t for t in sol.t]

plt = plot(
    dpi = 500,
    legend = true,
    xlabel = "безразмерное время",
    ylabel = "объем продаж"
)

plot!(
    plt, 
    t,
    ans1,
    label = "оборотные средства фирмы 1",
    color = :red
)

plot!(
    plt,
    t,
    ans2,
    label = "оборотные средства фирмы 2",
    color = :blue
)

savefig(plt, "./lab8/image/lab8_1.png")
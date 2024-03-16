using Plots
using DifferentialEquations

N = 10800
I0 = 208
R0 = 41
S0 = N - R0 - I0
aplha = 0.5
beta = 0.1


# u = [S0, I0, R0]
function ode(du, u, p, t)
    du[1] = 0
    du[2] = -beta * u[2]
    du[3] = beta * u[2]
end

u0 = [S0, I0, R0]
t_arr = (0, 20)

prob = ODEProblem(ode, u0, t_arr)
sol = solve(prob, dtmax = 0.05)

S = [u[1] for u in sol.u]
I = [u[2] for u in sol.u]
R = [u[3] for u in sol.u]
T = [t for t in sol.t]

plt = plot(
    dpi = 500,
    legend = true,
    xlabel = "время",
    ylabel = "численность"
)

plot!(
    plt,
    T,
    S,
    label = "Кол-во восприимчивых людей",
    color = :red
)

plot!(
    plt, 
    T,
    R,
    label = "Кол-во людей с иммунитетом",
    color = :blue
)

plot!(
    plt, 
    T,
    I,
    label = "Кол-во инфицированных людей",
    color = :black
)

savefig(plt, "./lab6/image/1.png")
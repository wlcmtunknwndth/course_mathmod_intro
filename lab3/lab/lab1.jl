#численность voisk
using Plots
using DifferentialEquations

x0 = 24000
y0 = 54000
vals = (x0, y0)
# начальный промежуток времени
# t = 0

a = 0.4
b = 0.64
c = 0.77
h = 0.3
arg1 = 5
arg2 = 5
arg3 = 1
coefs = (a, b, c, h, arg1, arg2, arg3, arg3)

function P(t, coef)
    return sin(t) + coef
end

function Q(t, coef)
    return cos(t) + coef
end

function F(du, vals, coefs, t)
    a, b, c, h, arg1, arg2, arg3, arg4 = coefs    
    x, y = vals
    du[1] = -a * x - b * y + P(t, arg1) + arg3
    du[2] = -c * x - h * y + Q(t, arg2) + arg4
end 

problem = ODEProblem(F, [x0, y0], [0, 0.75], coefs)

sol = solve(problem)

plt = plot(
    sol, 
    idxs = (0, 1),
    label = "the x army",
    color = :black,
)

plot!(
    sol,
    idxs = (0, 2),
    label = "the y army",
    color = :red,
    ylabel = "num of troops",
    xlabel = "time"
)

savefig(plt, ".\\lab3\\image\\task1.png")
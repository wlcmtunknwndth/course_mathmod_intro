using Plots
using DifferentialEquations

# Task 2

x0 = 24000
y0 = 54000
vals = (x0, y0)
# начальный промежуток времени

a = 0.35
b = 0.67
c = 0.77
h = 0.45
arg1 = 0
arg2 = 0
arg3 = 2
arg4 = 1
coefs = (a, b, c, h, arg1, arg2, arg3, arg4)

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
    du[2] = -c * x * y - h * y + Q(t, arg2) + arg4
end 

problem = ODEProblem(F, [x0, y0], [0, 0.001], coefs)

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
    xlabel = "time",
    title = "Nums of troops and rebels"
)

savefig(plt, ".\\lab3\\image\\task2.png")
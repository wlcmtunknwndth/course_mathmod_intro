using Plots
using DifferentialEquations

# Начальные условия
const n = 3.6
const dist = 9.6


# Функция траектории катера
function ship(u, p, t)
    return u / sqrt(n*n - 1)
end

# Функция для решения задачи
function task(dist, n, opt)
    # Сначала создаем пустую переменную
    r = 0.0
    Sector = 0.0 
    
    # Теперь в зависимости от переменной opt будет решать одно из двух условий
    if opt == 0
        r = dist/(n+1)
        Sector = (0, 2*pi)
    elseif opt == 1
        r = -(dist/(n+1))
        Sector = (-pi, pi)
    else
        return 
    end

    # Вызываем функцию для создания Дифференциального ур.
    ode = ODEProblem(ship, abs(r), Sector)

    # Решаем наше диф. уравнение
    sol = solve(ode, dtmax = 0.1)

    # Строим пустое полотно
    plt = plot(
        proj=:polar, #Задаем пустое полотно 
        dpi = 500, # Выбираем кол-во точек
        legend = true 
    )

    # @show sol.t
    # @show sol.u

    # Выбираем случайную точку из решения
    r_i = rand(1:size(sol.t)[1])
    # Получаем решение с помощью случайного индекса(или траекторию)
    r_angle = sol.t[r_i]


    # Рисуем основное полотно
    plot!(plt, 
        xlabel = "theta",
        ylabel = "r(t)",
        title = "Погоня",     
    )


    plot!(
        plt, 
        xlabel = "thera",
        ylabel = "r(t)",
        title = "Погоня. Случай " + string(opt),
    )

    savefig(plt, "lab_2_1")

    plot!(
        plt,
        [0.0, 0.0],
        [dist, r],
        label = "Движение катера по прямой",
        color = :black
    )
    scatter!(
        plt, 
        [0.0], 
        [dist],
        label = "",
        mc = :black
    )

    plot!(plt, 
        [r_angle, r_angle], 
        [0.0, sol.u[1]],
        label = "Направление лодки",
        color = :red,
    )
    scatter!(plt, 
        [r_angle],
        [sol.u[1]],
        label = "",
        mc = :red,
    )
        
    plot!(plt, 
        [sol.t[1], sol.t[1]], 
        [sol.u[1], sol.u[1]],
        label = "Направление катера",
        color = :blue,
    )

    savefig(plt, "lab_2_1")

    for i in 2:size(sol.t)[1]
        plot!(
            plt,
            [r_angle, r_angle],
            [sol.u[i-1], sol.u[i]],
            label = "",
            color = :red
        )
        scatter!(
            plt, 
            [r_angle],
            [sol.u[i]],
            label = "",
            mc = :red,
        )

        plot!(
            plt,
            [sol.t[i-1], sol.t[i]],
            [sol.u[i-1], sol.u[i]],
            label = "",
            color = :blue
        )
        scatter!(
            plt, 
            [sol.t[i]],
            [sol.u[i]],
            label = "",
            mc = :blue,
        )
    end

    name = "task_" * string(opt)


    # for i in sol.t
    #     if (round(sol.t[i], digits = 2) == round(sol.u[i], digits=2))
    #         @show sol.u[i]
    #         break
    #     end
    # end

    savefig(plt, name)
end

task(n, dist, 0)
task(n, dist, 1)



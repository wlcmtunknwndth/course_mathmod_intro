---
## Front matter
lang: ru-RU
title: "Лабораторная работа н.6"
subtitle: "Задач об эпидемии"
author:
  - "Петров Артем Евгеньевич"
institute:
  - Российский университет дружбы народов, Москва, Россия
date: 16 Марта 2024 

## i18n babel
babel-lang: russian
babel-otherlangs: english

## Formatting pdf
toc: false
toc-title: Содержание
slide_level: 2
aspectratio: 169
section-titles: true
theme: metropolis
header-includes:
 - \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
 - '\makeatletter'
 - '\beamer@ignorenonframefalse'
 - '\makeatother'
---

# Информация

## Докладчик

:::::::::::::: {.columns align=center}
::: {.column width="70%"}

  * Петров Артем Евгеньевич
  * Студент
  * Российский университет дружбы народов
  * [1032219251@rudn.ru](mailto:1032219251@rudn.ru)
  * <https://github.com/wlcmtunknwndth>

:::
::: {.column width="30%"}
:::
::::::::::::::

# Вводная часть

![Теоретическое введение](image/theory.jpg){#fig:001 width=70%}

## Вариант 22.
На море в тумане катер береговой охраны преследует лодку браконьеров.
На одном острове вспыхнула эпидемия. Известно, что из всех проживающих 
на острове (N=10 800) в момент начала эпидемии (t=0) число заболевших людей 
(являющихся распространителями инфекции) I(0)=208, А число здоровых людей с 
иммунитетом к болезни R(0)=41. Таким образом, число людей восприимчивых к 
болезни, но пока здоровых, в начальный момент времени S(0)=N-I(0)- R(0).
Постройте графики изменения числа особей в каждой из трех групп. 
Рассмотрите, как будет протекать эпидемия в случае: 
1. Если I(0) <= I*
2. Если I(0) > I*


# Решение

## 1. Подключение необходимых библиотек

Подключим необходимые библиотеки:

```Julia
using Plots
using DifferentialEquations
```

## 2. Выполнение лабораторной для случая I(0) <= I*

### Код программы: 

```Julia
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
```

### График

В итоге, получим вот такой график(рис. 2): 

![График моего заболеваемости в моем случае](image/1.png){#fig:002 width=70%}

## Выполнение лабораторной работы для случая I(0) > I*

### Код программы для построения графика заболеваемости

```Julia
N = 10800
I0 = 208
R0 = 41
S0 = N - R0 - I0
alpha = 0.5
beta = 0.1


# u = [S0, I0, R0]
function ode(du, u, p, t)
    du[1] = -alpha*u[1]
    du[2] = alpha*u[1] - beta * u[2]
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

savefig(plt, "./lab6/image/2.png")
```

### График заболеваемости для I(0) > I*

В итоге, получим вот такой график(рис. 3): 

![График моего заболеваемости в моем случае](image/2.png){#fig:003 width=70%}

# Выводы
На этой лабораторной работе я изучил основной синтаксис Julia, метод решения ОДУ и инструмент визуализации данных в Julia

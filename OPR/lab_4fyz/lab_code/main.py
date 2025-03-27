from decimal import Decimal

def function(x):
    return x**2 * 0.95 - 5.225 * x + 9.36


def generate_fibonacci_sequence(n):
    fib = [1, 1]
    for i in range(2, n + 1):
        fib.append(fib[i - 1] + fib[i - 2])
    return fib





a_avg = float(input("Введите левую границу интервала [a] : "))
b_avg = float(input("Введите правую границу интервала [b] : "))

eps = str(input("Введите точность поиска [eps]: "))




round_num = len(str(eps).split(".")[1])
round_num += 1

eps = float(eps)

def dehotomy(a, b, eps, iter):

    print("итерация : \t" + str(iter) + "\t" +  "граница - 1: " + str(round(a,round_num))
          + "\t" + "граница - 2: " + str(round(b,round_num)) + "\t" + "Длина промежутка : " +  str(round(abs(a - b), round_num)))




    if(b - a < 2 * eps):
        return [a,b]




    ab_avg = (a + b) / 2

    ab_l = ab_avg - eps/2
    ab_r = ab_avg + eps/2

    if(function(ab_l) < function(ab_r)):
        return dehotomy(a, ab_l, eps, iter + 1)
    else:
        return dehotomy(ab_l, b, eps, iter + 1)

def fibanach(fib, a, b, eps):

    n = len(fib) - 1


    # Начальные точки
    x1 = a + (b-a) * fib[n-2] / fib[n]
    x2 = a + (b-a) * fib[n-1] / fib[n]
    y1 = function(x1)
    y2 = function(x2)


    iter = 1

    while abs(b - a) > 2 * eps:  # Останавливаемся, когда интервал меньше eps

        print("итерация : \t" + str(iter) + "\t" + "граница - 1: " + str(
            round(a, round_num)) + "\t" + "граница - 2: " + str(
            round(b, round_num)) + "\t" + "Длина промежутка : " + str(round(abs(a - b), round_num)))

        #print("итерация : \t" + str(iter))
        iter += 1


        if y1 > y2:
            a = x1
            x1 = x2
            y1 = y2
            x2 = a + b - x1
            y2 = function(x2)
        else:
            b = x2
            x2 = x1
            y2 = y1
            x1 = a + b - x2
            y1 = function(x1)


    # Возвращаем середину интервала как приближение экстремума
    return (a + b) / 2








#метод дехотомии



out_dehot = dehotomy(a_avg, b_avg, eps, 1)

print(str('*' * 100))

mid_dehot = sum(out_dehot)/2

print("Промежуток : \t" + str(round(out_dehot[0], round_num)) + "\t" + str(round(out_dehot[1], round_num)))
print("Среднее промежутка : \t" + str(round(mid_dehot, round_num)))
print("y : \t" + str(round(function(mid_dehot), round_num)))

print(str('*' * 100))



#метод фибаначи

out_fibanach = fibanach(generate_fibonacci_sequence(30), a_avg, b_avg, eps)


print(str('*' * 100))
print("Среднее промежутка : \t" + str(round(out_fibanach, round_num)))
print("y : \t" + str(round(function(out_fibanach), round_num)))
print(str('*' * 100))







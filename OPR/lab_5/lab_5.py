def f(x):
    return 1.36 * x ** 2 - 4.488 * x + 5.82


def df(x):  # Первая производная
    return 2.72 * x - 4.488


def d2f(x):  # Вторая производная (гессиан)
    return 2.72


def newton_method(a, b, tol, max_iter):
    # Проверка, что функция выпукла вниз на интервале
    if d2f(a) <= 0 or d2f(b) <= 0:
        raise ValueError("Функция не выпукла вниз на данном интервале!")

    # Начальное приближение - середина интервала
    x = (a + b) / 2

    print("\nИтерационный процесс:")
    print(f"{'Итерация':<10} | {'x':<15} | {'f(x)':<15} | {'f\'(x)':<15} | {'f\'\'(x)':<15}")
    print("-" * 75)

    for i in range(max_iter):
        grad = df(x)
        hess = d2f(x)
        x_new = x - grad / hess

        print(f"{i:<10} | {x:<15.6f} | {f(x):<15.6f} | {grad:<15.6f} | {hess:<15.6f}")

        if abs(x_new - x) < tol:
            print(f"\nДостигнута заданная точность {tol} на итерации {i}.")
            break
        x = x_new
    else:
        print(f"\nДостигнуто максимальное число итераций {max_iter}.")

    return x, f(x)


# Ввод параметров
print("Выполнено Мельниковым Александром ИСиТ-221")
print("Поиск минимума функции f(x) = 1.36x^2 - 4.488x + 5.82 методом Ньютона")
a = float(input("Введите начало интервала a: "))
b = float(input("Введите конец интервала b: "))
tol = float(input("Введите точность (например, 0.0001): "))
max_iter = int(10000)

# Проверка корректности интервала
if a >= b:
    raise ValueError("Начало интервала должно быть меньше конца!")

# Вычисление
try:
    min_x, min_val = newton_method(a, b, tol, max_iter)

    # Аналитическое решение для проверки
    a_coeff, b_coeff = 1.36, -4.488
    x_analytic = -b_coeff / (2 * a_coeff)
    f_analytic = f(x_analytic)

    # Проверка, что найденный минимум внутри интервала
    if not (a <= min_x <= b):
        print(f"\nПредупреждение: найденный минимум x = {min_x:.6f} не принадлежит интервалу [{a}, {b}]!")

    # Вывод результатов
    print("\nРезультаты:")
    print(f"Численное решение: x_min = {min_x:.8f}, f(x_min) = {min_val:.8f}")
    print(f"Аналитическое решение: x_min = {x_analytic:.8f}, f(x_min) = {f_analytic:.8f}")
    print(f"Разница: {abs(min_x - x_analytic):.2e}")

except ValueError as e:
    print(f"\nОшибка: {e}")

# Визуализация (опционально)
try:
    import matplotlib.pyplot as plt
    import numpy as np

    x_vals = np.linspace(a - 1, b + 1, 400)
    y_vals = f(x_vals)

    plt.figure(figsize=(10, 6))
    plt.plot(x_vals, y_vals, label="f(x) = 1.36x² - 4.488x + 5.82")
    plt.axvspan(a, b, color='lightgray', alpha=0.3, label=f"Интервал поиска [{a}, {b}]")
    plt.scatter([min_x], [min_val], c='red', label=f"Найденный минимум ({min_x:.4f}, {min_val:.4f})")
    plt.xlabel("x")
    plt.ylabel("f(x)")
    plt.title("График функции и интервал поиска минимума")
    plt.grid(True)
    plt.legend()
    plt.show()
except ImportError:
    print("\nДля визуализации установите matplotlib: pip install matplotlib")
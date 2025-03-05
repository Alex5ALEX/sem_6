import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

x = np.arange(0.1, 3.1, 0.1)
y = np.array([6.35, 6.21, 6.66, 6.64, 6.86, 6.74, 7.05, 6.92, 6.82, 7.05, 7.22, 6.79, 7.09, 6.84, 6.87,
              7.09, 6.51, 6.26, 6.11, 5.87, 5.43, 5.16, 5.04, 4.52, 4.47, 4.05, 3.53, 3.27, 3.01, 6.35])

print(sum(y))

out = 0

for i in range(len(x)):
    out += x[i] * y[i]

print(out)

out = 0


for i in range(len(x)):
    out += x[i]**2 * y[i]

print(out)


def quadratic_func(x, a, b, c):
    return a * x**2 + b * x + c


popt, _ = curve_fit(quadratic_func, x, y)
a, b, c = popt

# аппроксимирующая функция
y_approx = quadratic_func(x, a, b, c)


print(f"Квадратичная функция: y = {a:}x² + {b:}x + {c:}")
print(f"Коэффиценты: a = {a:.4f}, b = {b:.4f}, c = {c:.4f} ")


plt.figure(figsize=(10, 6))
plt.plot(x, y, 'ro', label='Исходные данные')
plt.plot(x, y_approx, 'b-', label='Квадратичная аппроксимация')
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Аппроксимация функции многочленом второй степени')
plt.legend()
plt.grid(True)
plt.show()




# Загрузка необходимых библиотек
library(ggplot2)
# Параметры нормального распределения
mu <- 50
sigma <- 10
sample_size <- 120

# Генерация данных
set.seed(123) # Для воспроизводимости
data <- rnorm(sample_size, mean = mu, sd = sigma)

# Построение гистограммы
hist_plot <- ggplot(data.frame(speed = data), aes(x = speed)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "blue",
  color = "black", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Гистограмма и плотность распределения скорости соединения",
       x = "Скорость (Мбит/с)", y = "Плотность") +
  theme_minimal()
print(hist_plot)

print(data);



# Вычисление вероятностей для нормального распределения
probability_internet_speed <- dnorm(data, mean = mu, sd = sigma)

print(probability_internet_speed)


# Построение графика
plot(data, probability_internet_speed,
     main = "Вероятность для нормального распределения",
     xlab = "скорость",
     ylab = "Вероятность (probability_internet_speed)",
     pch = 1,          # Тип точки
     col = "black")     # Цвет точек














































# Среднее значение
mean_empirical <- mean(data)

# Дисперсия
var_empirical <- var(data)

# Стандартное отклонение
sd_empirical <- sd(data)

# Вывод результатов
cat("Эмпирическое среднее:", mean_empirical, "\n")

cat("Эмпирическая дисперсия:", var_empirical, "\n")

cat("Эмпирическое стандартное отклонение:", sd_empirical, "\n")









# Теоретические характеристики
mean_theoretical <- mu
var_theoretical <- sigma^2
sd_theoretical <- sigma

# Вывод результатов
cat("Теоретическое среднее:", mean_theoretical, "\n")

cat("Теоретическая дисперсия:", var_theoretical, "\n")

cat("Теоретическое стандартное отклонение:", sd_theoretical, "\n")







# Разница между эмпирическими и теоретическими значениями
diff_mean <- abs(mean_empirical - mean_theoretical)
diff_var <- abs(var_empirical - var_theoretical)
diff_sd <- abs(sd_empirical - sd_theoretical)

# Вывод разниц
cat("Разница в среднем значении:", diff_mean, "\n")

cat("Разница в дисперсии:", diff_var, "\n")

cat("Разница в стандартном отклонении:", diff_sd, "\n")








# Вероятность P(X < 40)
prob_less_40 <- pnorm(q = 40, mean = mu, sd = sigma)

# Вывод результата
cat("Вероятность того, что скорость соединения будет меньше 40 Мбит/с:",
    prob_less_40, "\n")



# Вероятность P(X < 40)
prob_less_40_emp <- pnorm(q = 40, mean = mean_empirical, sd = sd_empirical)

# Вывод результата
cat("Вероятность того, что скорость соединения будет меньше 40 Мбит/с эмпирическая:",
    prob_less_40_emp, "\n")






# Создание значений x для графика
x_values <- seq(from = 20, to = 80, length.out = 1000)
cdf_values <- pnorm(q = x_values, mean = mu, sd = sigma)
ecdf_values <- ecdf(data) 


# График функции распределения
cdf_plot <- ggplot(data.frame(x = x_values, cdf = cdf_values),
  aes(x = x, y = cdf)) +
  geom_line(color = "blue", size = 1) +
  ggplot(data.frame(x = x_values, cdf = ecdf_values),
  aes(x = x, y = cdf)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Функция распределения скорости соединения",
       x = "Скорость (Мбит/с)", y = "F(x)") +
  theme_minimal()

print(cdf_plot)









# Создание значений x для графика
x_values <- seq(from = 20, to = 80, length.out = 1000)

# Теоретическая CDF (нормальное распределение)
cdf_values <- pnorm(q = x_values, mean = mu, sd = sigma)

# Эмпирическая CDF
ecdf_fun <- ecdf(data)
ecdf_values <- ecdf_fun(x_values)

# Создаем dataframe для ggplot
plot_data <- data.frame(
  x = rep(x_values, 2),
  y = c(cdf_values, ecdf_values),
  type = rep(c("Теоретическая CDF", "Эмпирическая ECDF"), each = length(x_values))
)

# График функций распределения
cdf_plot <- ggplot(plot_data, aes(x = x, y = y, color = type)) +
  geom_line(size = 1) +
  labs(title = "Сравнение теоретической и эмпирической функций распределения",
       x = "Скорость (Мбит/с)", y = "F(x)",
       color = "Тип распределения") +
  theme_minimal() +
  scale_color_manual(values = c("Теоретическая CDF" = "blue", "Эмпирическая ECDF" = "red"))

print(cdf_plot)
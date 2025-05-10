# Установка необходимых пакетов (если они еще не установлены)
if (!require(readxl)) {
  install.packages("readxl")
}

# Подключение библиотеки для работы с Excel
library(readxl)

# Чтение данных из Excel-файла
# Предположим, что файл называется "cars_data.xlsx" и находится в рабочей директории
#file_path <- "cars_.xlsx"
#вводим файл в ручную в переменную выше
file_path <- "E:/university/sem_6/Базы_Знан/lab_3/VAR1_10.xlsx"

# Чтение данных из Excel-файла
data <- read_excel(file_path, sheet = "var7")



qqnorm(data$stress_level_before_vacation, main = "Normal Q-Q Plot (Before Vocation)")
qqline(data$stress_level_before_vacation, col = "red")


qqnorm(data$stress_level_after_vacation, main = "Normal Q-Q Plot (After Vocation)")
qqline(data$stress_level_after_vacation, col = "red")


# Тест Шапиро для времени до отпуска
shapiro_before <- shapiro.test(data$stress_level_before_vacation)
cat("Тест Шапиро для времени до отпуска:\n")
print(shapiro_before)

# Тест Шапиро для времени после отпуска
shapiro_after <- shapiro.test(data$stress_level_after_vacation)
cat("Тест Шапиро для времени  после отпуска:\n")
print(shapiro_after)





library(ggplot2) 

# Коробчатые диаграммы
ggplot(data, aes(x = "Task Time")) +
  geom_boxplot(aes(y = stress_level_before_vacation, color = "Before Vocation"), width = 0.4) +
  geom_boxplot(aes(y = stress_level_after_vacation, color = "After Vocation"), width = 0.4) +
  labs(title = "Comparison of Task Time Before and After Vocation",
       x = "Time Period",
       y = "Task Time (minutes)") +
  theme_minimal() +
  scale_color_manual(values = c("Before Vocation" = "blue", "After Vocation" = "green"),
                     name = "Legend")


#парный t-тест
t_test_result <- t.test(data$stress_level_before_vacation, 
                        data$stress_level_after_vacation, 
                        paired = TRUE)
# Вывод результатов теста
print(t_test_result)



# Дополнительные вычисления
mean_before <- mean(data$stress_level_before_vacation, na.rm = TRUE)
mean_after <- mean(data$stress_level_after_vacation, na.rm = TRUE)
time_difference <- mean_before - mean_after

cat("Средней уровень стреса до отпуска:", mean_before, "\n")
## Средней уровень стреса до отпуска: 72.22732 
cat("Средней уровень стреса после отпуска:", mean_after, "\n")
## Средней уровень стреса после отпуска: 52.43022 
cat("Разница в уровне стреса:", time_difference, "\n")
## Разница в уровне стреса: 19.79709 



















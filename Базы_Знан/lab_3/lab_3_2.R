
library(dplyr)
library(ggplot2)


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
file_path <- "E:/university/sem_6/Базы_Знан/lab_3/Var1_10_N.xlsx"

# Чтение данных из Excel-файла
data <- read_excel(file_path, sheet = "v7-10")



variant7_data <- data[data$Variant == "Variant7", ]


printer_model1 <- variant7_data[variant7_data$Group == "printer_model1", "Value"]
print(printer_model1)

printer_model2 <- variant7_data[variant7_data$Group == "printer_model2", "Value"]
print(printer_model2)

#основные данные
summary_stats_model1 <- summary(printer_model1)
print(summary_stats_model1)

summary_stats_model2 <- summary(printer_model2)
print(summary_stats_model2)





# Строим boxplot для variant7_data
ggplot(variant7_data, aes(x = Group, y = Value, fill = Group)) +
  geom_boxplot() +
  labs(
    title = "Сравнение printer_model1 и printer_model2",
    x = "Модель принтера",
    y = "Значение"
  ) +
  theme_minimal() +
  scale_fill_manual(
    values = c("printer_model1" = "blue", "printer_model2" = "green"),
    name = "Модель принтера"
  )


# Q-Q график для printer_model1
qqnorm(variant7_data$Value[variant7_data$Group == "printer_model1"], 
       main = "Q-Q Plot для printer_model1", col = "blue")
qqline(variant7_data$Value[variant7_data$Group == "printer_model1"], col = "red")


# Q-Q график для printer_model2
qqnorm(variant7_data$Value[variant7_data$Group == "printer_model2"], 
       main = "Q-Q Plot для printer_model2", col = "blue")
qqline(variant7_data$Value[variant7_data$Group == "printer_model2"], col = "red")


# Тест Шапиро для printer_model1
shapiro_test_printer_model1 <- shapiro.test(variant7_data$Value[variant7_data$Group == "printer_model1"])
cat("Тест Шапиро для printer_model1:\n")
print(shapiro_test_printer_model1)
                    

# Тест Шапиро для printer_model2
shapiro_test_printer_model2 <- shapiro.test(variant7_data$Value[variant7_data$Group == "printer_model2"])
cat("Тест Шапиро для printer_model2:\n")
print(shapiro_test_printer_model2)



var_test_result <- var.test(Value ~ Group, data = variant7_data)
cat("F-тест для равенства дисперсий:\n")
## F-тест для равенства дисперсий:
print(var_test_result)


#парный t-тест
t_test_result <- t.test(variant7_data$Group == "printer_model1", 
                        variant7_data$Group == "printer_model2", 
                        paired = TRUE)
# Вывод результатов теста
print(t_test_result)




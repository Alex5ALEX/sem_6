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
file_path <- "E:/university/sem_6/Базы_Знан/lab_2/car_14_06.xlsx"

# Чтение данных из Excel-файла
data <- read_excel(file_path, sheet = "S2023")



library(ggplot2) 


str(data)


selected_class <- "C"  # Замените на нужный класс из ваших данных
class_data <- data[data$Класс == selected_class, ]  # Фильтруем данные



# Подсчет количества наблюдений по категориям (например, fuel_type)
category_counts <- table(class_data$Привод)  # Замените `fuel_type` на нужный столбец

# Преобразуем в датафрейм для удобства
category_df <- as.data.frame(category_counts)
colnames(category_df) <- c("Category", "Count")

# Выводим таблицу
print(category_df)




# добавить зачения на столбиках
# Столбчатая диаграмма
ggplot(category_df, aes(x = Category, y = Count, fill = Category)) +
  geom_bar(stat = "identity") +
  # Добавляем текст с количеством элементов над каждым столбцом
  geom_text(aes(label = Count), 
            vjust = -0.5,  # Положение над столбцом
            size = 4,      # Размер текста
            color = "black") +
  labs(title = paste("Распределение приводов для класса", selected_class),
       x = "Категория",
       y = "Количество") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        # Дополнительные настройки темы
        legend.position = "none")  # Убираем легенду, так как категории и так подписаны

# Круговая диаграмма
ggplot(category_df, aes(x = "", y = Count, fill = Category)) +
  geom_col() +
  coord_polar(theta = "y") +
  geom_text(aes(label = paste(Count, "(", round(Count/sum(Count)*100, 1), "%)")),
            position = position_stack(vjust = 0.5)) +
  labs(title = paste("Распределение приводов для класса", selected_class)) +
  theme_void()


# Выбираем количественный признак (например, "price" — цена)
quant_var <- class_data$Пробег


# Базовая статистика (min, max, mean, median, sd)
summary_stats <- summary(quant_var)
std_dev <- sd(quant_var, na.rm = TRUE)  # стандартное отклонение




#-------------------------------------------
#вывод описательной статистики в ворд
#-------------------------------------------



# Установка пакетов (если не установлены)
if (!require("pacman")) install.packages("pacman")
pacman::p_load(flextable, officer, ggplot2)

# Пример данных (замените на свои)
data <- data.frame(quant_var)

# Создаём датафрейм с описательной статистикой
stats_df <- data.frame(
  "Показатель" = c("Наблюдения", "Минимум", "Максимум", "Среднее", 
                   "Медиана", "Станд. отклонение", "Дисперсия"),
  "Значение" = c(
    length(na.omit(data$quant_var)),
    min(data$quant_var, na.rm = TRUE),
    max(data$quant_var, na.rm = TRUE),
    mean(data$quant_var, na.rm = TRUE),
    median(data$quant_var, na.rm = TRUE),
    sd(data$quant_var, na.rm = TRUE),
    var(data$quant_var, na.rm = TRUE)
  )
)

# Форматируем числовые значения
stats_df$Значение <- round(stats_df$Значение, 2)

# Создаём таблицу
ft <- flextable(stats_df) |> 
  set_caption("Описательная статистика количественного признака") |> 
  theme_zebra() |> 
  align(align = "center", part = "all") |> 
  autofit()

# Создаём графики
hist_plot <- ggplot(data, aes(x = quant_var)) +
  geom_histogram(fill = "skyblue", bins = 15, color = "white") +
  labs(title = "Гистограмма распределения",
       x = "Значение", y = "Частота") +
  theme_minimal()


box_plot <- ggplot(data, aes(y = quant_var)) +
  geom_boxplot(fill = "lightgreen", color = "darkgreen") +
  labs(title = "Boxplot количественного признака", 
       y = "Значение") +
  theme_minimal()

print(hist_plot);
print(box_plot);

# Сохраняем графики во временные файлы
temp_hist <- tempfile(fileext = ".png")
temp_box <- tempfile(fileext = ".png")

ggsave(temp_hist, plot = hist_plot, width = 6, height = 4, dpi = 300)
ggsave(temp_box, plot = box_plot, width = 6, height = 4, dpi = 300)

# Создаём Word-документ
doc <- read_docx() |> 
  body_add_par("Анализ количественного признака", style = "heading 1") |> 
  body_add_flextable(ft) |> 
  body_add_par("Визуализации", style = "heading 2") |> 
  body_add_par("Гистограмма распределения:", style = "heading 3") |> 
  body_add_img(src = temp_hist, width = 6, height = 4) |> 
  body_add_par("Boxplot (анализ выбросов):", style = "heading 3") |> 
  body_add_img(src = temp_box, width = 6, height = 4)

# Сохраняем документ
print(doc, target = "analysis_report.docx")

# Удаляем временные файлы
unlink(c(temp_hist, temp_box))

message("Отчёт успешно сохранён в файл 'analysis_report.docx'")


#-------------------------------------------
#Принадлежность к генеральной совокупности
#-------------------------------------------


# Извлекаем данные
probег <- na.omit(class_data$Пробег)

# 2. Основные описательные статистики
cat("\n=== ОСНОВНЫЕ СТАТИСТИКИ ===\n")
desc_stats <- data.frame(
  Наблюдения = length(probег),
  Среднее = mean(probег),
  Медиана = median(probег),
  "Ст. отклонение" = sd(probег),
  Асимметрия = moments::skewness(probег),
  Эксцесс = moments::kurtosis(probег) - 3,
  Минимум = min(probег),
  Максимум = max(probег)
)
print(desc_stats)

# 3. Тесты на нормальность
# Shapiro-Wilk test
cat("\n=== ТЕСТ ШАПИРО-УИЛКА НА НОРМАЛЬНОСТЬ ===\n")
shapiro_test <- shapiro.test(probег)
print(shapiro_test)

# 4. Визуальная проверка
cat("\n=== ГРАФИЧЕСКАЯ ПРОВЕРКА (панель Plots) ===\n")

# Гистограмма с нормальной кривой
hist(probег, freq = FALSE, col = "skyblue", main = "Гистограмма распределения пробега",
     xlab = "Пробег", ylab = "Плотность")
curve(dnorm(x, mean = mean(probег), sd = sd(probег)), 
      col = "red", lwd = 2, add = TRUE)
legend("topright", legend = "Нормальное распределение", col = "red", lwd = 2)

# Q-Q plot
qqnorm(probег, main = "Q-Q plot для проверки нормальности")
qqline(probег, col = "red")

# 5. Итоговый вывод
cat("\n=== ВЫВОД ===\n")
if (shapiro_test$p.value > 0.05) {
  cat("По результатам теста Шапиро-Уилка (p =", round(shapiro_test$p.value, 4), 
      "> 0.05):\nГипотеза о нормальном распределении НЕ отвергается.\n",
      "Распределение пробега не имеет значимых отклонений от нормального.")
} else {
  cat("По результатам теста Шапиро-Уилка (p =", round(shapiro_test$p.value, 4), 
      "<= 0.05):\nГипотеза о нормальном распределении ОТВЕРГАЕТСЯ.\n",
      "Распределение пробега значимо отличается от нормального.")
}






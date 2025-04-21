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





# Столбчатая диаграмма
ggplot(category_df, aes(x = Category, y = Count, fill = Category)) +
  geom_bar(stat = "identity") +
  labs(title = paste("Распределение приводов для класса", selected_class),
       x = "Категория",
       y = "Количество") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

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


# Создаём датафрейм для stargazer
stats_df <- data.frame(
  "Показатель" = c("Минимум", "Максимум", "Среднее", "Медиана", "Станд. отклонение"),
  "Значение" = c(
    min(quant_var, na.rm = TRUE),
    max(quant_var, na.rm = TRUE),
    mean(quant_var, na.rm = TRUE),
    median(quant_var, na.rm = TRUE),
    sd(quant_var, na.rm = TRUE)
  )
)

# Экспорт в Word
install.packages(c("flextable", "officer"))  # если не установлены
library(flextable)
library(officer)

# Создаём таблицу
ft <- flextable(stats_df) |> 
  set_caption("Описательная статистика") |> 
  theme_zebra()

# Сохраняем в Word
doc <- read_docx() |> 
  body_add_flextable(ft)

print(doc, target = "descriptive_stats.docx")  # создаст .docx




library(ggplot2)

# Гистограмма распределения
ggplot(data, aes(x = quant_var)) +
  geom_histogram(fill = "skyblue", bins = 10) +
  labs(title = "Распределение количественного признака",
       x = "Значение", y = "Частота")

# Boxplot (для выбросов)
ggplot(data, aes(y = quant_var)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Boxplot количественного признака", y = "Значение")

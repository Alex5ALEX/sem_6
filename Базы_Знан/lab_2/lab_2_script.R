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
file_path <- read_excel("E:/university/sem_6/Базы_Знан/lab_2/car_14_06.xlsx", 
                        sheet = "S2023")
View(file_path)
data <- read_excel(file_path)

# Просмотр структуры данных
print(str(data))

# Выборка данных по признакам: год, класс автомобиля, привод и пробег
# Предположим, что столбцы в Excel называются "Year", "Class", "Drive", "Mileage"
filtered_data <- data[, c("Год_выпуска", "Класс", "Привод", "Пробег")]

# Проверка на наличие пропущенных значений в выборке 
missing_values <- sapply(filtered_data, function(x) sum(is.na(x)))

# Вывод количества пропущенных значений для каждого столбца
print("Количество пропущенных значений по столбцам:")
print(missing_values)

# Если нужно вывести строки с пропущенными значениями
rows_with_missing <- filtered_data[rowSums(is.na(filtered_data)) > 0, ]
print("Строки с пропущенными значениями:")
print(rows_with_missing)
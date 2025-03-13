#install.packages("psych");
#install.packages("ggplot2");
#install.packages("lmtest");
#install.packages("MASS");
#install.packages("dplyr");


print("Hello World");


mu <- 50;
sigma <- 10;


normal_density <- function(x){
  (1 / (sigma * sqrt(2 * pi))) * 
    exp(-((x - mu)^2) / (2 * sigma^2));
};

x_value <- seq(20, 80, by = 0.1);


densities <- normal_density(x_value);


plot(x_value, densities, type = "l",
     main="Нормальное распределение", xlab = "x",
     ylab = "Плотность вероятности", col="blue");


# вероятность что точка находится в зоне < 40
probability <- pnorm(40, mean = mu, sd = sigma)
print(probability)





set.seed(1223);

my_x_value <- sample(20:80, 20, replace = TRUE);
#rm(my_x_value);

my_densities <- normal_density(my_x_value);
#rm(my_densities);

plot(my_x_value, my_densities, 
     main = "График точек", 
     xlab = "Значения X", 
     ylab = "Значения Y", 
     col = "blue", 
     pch = 19);

#среднее из значений
print(mean(my_x_value));

#дисперсия из значений
print(sigma^2);


i<-20
while(i <= 80)
{
  for(y in )
  
  
  
  
  
  i = i + 10;
}
rm(i);


# Построение гистограммы
hist(my_densities, breaks = 20, freq = FALSE, col = "lightblue",
     xlab = "Значения", ylab = "Плотность", main = "Гистограмма с кривой плотности")

# Наложение кривой плотности из ваших массивов
lines(my_x_value, my_densities, col = "red", lwd = 2)

# Добавление легенды
legend("topright", legend = "Плотность", col = "red", lwd = 2)



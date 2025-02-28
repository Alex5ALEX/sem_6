#install.packages("psych");
#install.packages("ggplot2");
#install.packages("lmtest");
#install.packages("MASS");
#install.packages("dplyr");

<<<<<<< Updated upstream
<<<<<<< Updated upstream
print("Hello World");
=======
=======
>>>>>>> Stashed changes

mu <- 50;
sigma <- 10;


normal_density <- function(x){
  (1 / (sigma * sqrt(2 * pi))) * 
    exp(-((x - mu)^2) / (2 * sigma^2));
};

x_value <- seq(20, 80, by = 0.1);


densities <- normal_density(x_value);


plot(x_value, densities, type = "l", main="Нормальное распределение", xlab = "x", ylab = "Плотность вероятности", col="blue");


# вероятность что точка находится в зоне < 40
probability <- pnorm(40, mean = mu, sd = sigma)
print(probability)





set.seed(1223);

my_x_value <- sample(20:80, 200, replace = TRUE);
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
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes

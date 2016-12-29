library(dplyr)
library(tidyr)
library(stringr)

parse_data <- function(df) {
  
  names(df) <- c("year", "Cічень", "Лютий", "Березень",
                 "Квітень", "Травень", "Червень", "Липень",
                 "Серпень", "Вересень", "Жовтень", "Листопад",
                 "Грудень", "Середньорічна")
  
  df <- df %>% 
    gather(key = "month", value = "temperature", -year) %>% 
    filter(month != "Середньорічна")
  
  df$temperature <- str_replace_all(
      string = df$temperature, 
      pattern = ",", 
      replacement = ".") %>% 
  as.numeric()
  
  df$month = factor(df$month, 
                    levels = c("Cічень", "Лютий", "Березень", "Квітень", 
                               "Травень", "Червень", "Липень", "Серпень", 
                               "Вересень", "Жовтень", "Листопад", "Грудень"),
                             ordered = TRUE)
  
  return(df)
    
}

df <- parse_data(df)
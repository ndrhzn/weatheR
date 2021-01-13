library(dplyr)
library(tidyr)
library(stringr)

parse_data <- function(filename = 'data/raw.csv') {
  
  df <- read.csv(filename, stringsAsFactors = FALSE, fileEncoding = 'UTF-8')
  
  names(df) <- c("year", "Cічень", "Лютий", "Березень",
                 "Квітень", "Травень", "Червень", "Липень",
                 "Серпень", "Вересень", "Жовтень", "Листопад",
                 "Грудень", "Середньорічна")
  
  df <- df %>% 
    gather(key = "month", value = "temperature", -year) %>% 
    filter(month != "Середньорічна") %>% 
    mutate(temperature =  str_replace_all(string = temperature, 
                                          pattern = ",", 
                                          replacement = "."),
           temperature = as.numeric(temperature),
           month = factor(month, 
                          levels = c("Cічень", "Лютий", "Березень", "Квітень", 
                                     "Травень", "Червень", "Липень", "Серпень", 
                                     "Вересень", "Жовтень", "Листопад", "Грудень"),
                          ordered = TRUE)) %>% 
    arrange(year, month)
  
  return(df)
    
}

df <- parse_data()

write.csv(x = df, file = 'data/weather.csv', row.names = FALSE, fileEncoding = 'UTF-8')
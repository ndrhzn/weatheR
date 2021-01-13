library(rvest)

get_data <- function() {
  
  page <- html_session('http://cgo-sreznevskyi.kyiv.ua/index.php?fn=k_klimat&f=kyiv')
  
  table <- page %>% 
    html_nodes('h4+ .tablemain') %>% 
    html_table() %>% 
    as.data.frame()
  
  return(table)
  
}

df <- get_data()

write.csv(x = df, file = 'data/raw.csv', row.names = FALSE, fileEncoding = 'UTF-8')

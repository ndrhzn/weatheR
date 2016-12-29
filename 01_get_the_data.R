library(rvest)

get_data <- function() {
  
  page <- html_session("http://cgo.kiev.ua/index.php?fn=k_klimat&f=kyiv&p=1")
  
  table <- page %>% 
    html_nodes('h4+ .tablemain') %>% 
    html_table() %>% 
    as.data.frame()
  
  return(table)
  
}

df <- get_data()
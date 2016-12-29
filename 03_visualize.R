library(dplyr)
library(ggplot2)
source("~/R/weatheR/01_get_the_data.R")
source("~/R/weatheR/02_parse_the_data.R")

df <- df %>% 
  filter(year > 1899) %>% 
  group_by(month) %>% 
  mutate(mean = mean(temperature, na.rm = T)) %>% 
  ungroup()

ggplot(df)+
  geom_linerange(aes(year, ymin = mean, ymax = temperature, 
                     color = temperature), size = 0.5)+
  geom_line(aes(year, mean), color = "#3A3F4A")+
  #geom_point(aes(year, temperature, color = temperature), alpha = 0.7)+
  geom_smooth(aes(year, temperature), se = F, method = "lm")+
  scale_y_continuous(name = NULL, breaks = seq(-25, 25, 5))+
  scale_x_continuous(name = NULL, breaks = c(1900, 2014))+
  guides(color = guide_colorbar(title = "Середньомісячна температура в Києві, C", 
                                title.position = "top"))+
  viridis::scale_color_viridis()+
  facet_wrap(~month, ncol = 12)+
  theme_minimal(base_family = "Ubuntu Condensed")+
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major = element_line(linetype = "dotted", size = 0.6),
        panel.grid.minor = element_line(linetype = "dotted", size = 0.6),
        panel.margin.x = unit(2, "lines"),
        text = element_text(family = "Ubuntu Condensed", color = "#3A3F4A"),
        axis.text = element_text(size = 14),
        strip.text = element_text(size = 14),
        legend.position = "top",
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12),
        legend.key.height = unit(2, "pt"),
        legend.key.width = unit(50, "pt"),
        plot.background = element_rect(fill = "#EFF2F4"),
        plot.margin = unit(c(2, 2, 2, 2), "cm"))
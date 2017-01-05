library(dplyr)
library(ggplot2)
library(stringr)
source("~/R/weatheR/01_get_the_data.R")
source("~/R/weatheR/02_parse_the_data.R")

df <- df %>% 
  filter(year > 1899) %>% 
  group_by(month) %>% 
  mutate(mean = mean(temperature, na.rm = T)) %>% 
  ungroup()

png(filename = "weather.png", width = 1600, height = 1200, type = "cairo")

ggplot(df)+
  geom_linerange(aes(year, ymin = mean, ymax = temperature, 
                     color = temperature), size = 0.5)+
  geom_line(aes(year, mean), color = "#3A3F4A", size = 1)+
  #geom_point(aes(year, temperature, color = temperature), alpha = 0.7)+
  geom_smooth(aes(year, temperature), se = F, method = "lm", color = "#3A3F4A", size = 0.7)+
  scale_y_continuous(name = NULL, breaks = seq(-25, 25, 5))+
  scale_x_continuous(name = NULL, breaks = c(1900, 2014))+
  guides(color = guide_colorbar(title = "Середньомісячна температура в Києві, C", 
                                title.position = "top"))+
  labs(title = "Температура в Києві, 1900-2014 рік",
       subtitle = str_wrap("Горизонтальні лінії на графіку позначають середню температуру для кожного місяця за період спостережень з 1900 до 2014 року включно. Довжина вертикальних ліній позначає різницю між середньомісячною температурою в конкретному році та середньою температурою для цього місяця у 1900-2014 роках. Лінія тренду покликана показати зв’язок між змінними «рік» та «температура»", 160),
       caption = "\nДані: Центральна геофізична обсерваторія Візуалізація: textura.in.ua")+
  viridis::scale_color_viridis(end = 0.9)+
  facet_wrap(~month, ncol = 12)+
  theme_minimal(base_family = "Ubuntu Condensed")+
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_line(linetype = "dotted", size = 0.6),
        panel.margin.x = unit(3, "lines"),
        text = element_text(family = "Ubuntu Condensed", color = "#3A3F4A"),
        axis.text.y = element_text(size = 18),
        axis.text.x = element_text(size = 16),
        strip.text = element_text(size = 18, color = "#3A3F4A"),
        legend.position = "top",
        legend.title = element_text(size = 18),
        legend.text = element_text(size = 16),
        legend.key.height = unit(2, "pt"),
        legend.key.width = unit(150, "pt"),
        plot.title = element_text(face = "bold", size = 40, margin = margin(b = 20)),
        plot.subtitle = element_text(size = 20, margin = margin(b = 20, t = 10)),
        plot.caption = element_text(size = 18, margin = margin(b = 10, t = 20), color = "#5D646F"),
        plot.background = element_rect(fill = "#EFF2F4"),
        plot.margin = unit(c(3, 3, 3, 3), "cm"))

dev.off()
if(!"pacman" %in% installed.packages()) {install.packages("pacman")}
pacman::p_load(tidyverse, vroom, CGPfunctions, ggrepel, showtext, sysfonts, ggtext, naniar, countrycode)

font_add_google("Source Sans Pro", "ssp")
showtext_auto()

url_data <- "https://www.cato.org/sites/cato.org/files/2023-01/human-freedom-index-2022.csv"

hfi_data <- vroom(url_data)
glimpse(hfi_data)

colpal <- c("#3C307E", "#95CBE3")


hfi_data %>%
  select(year, countries, region, hf_score) %>%
  filter(year %in% c(2000, 2020)) %>%
  group_by(countries) %>%
  mutate(na = naniar::any_na(hf_score)) %>%
  filter(!na) %>%
  ungroup() %>%
  ggplot(aes(x = hf_score, color = factor(year), group = year)) + 
  geom_density(linewidth = 0.8) + 
  scale_color_manual(values = colpal) +
  scale_x_continuous(
    limits = c(2, 10),
    breaks = seq(2, 10, 2),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name = "Density",
    limits = c(0, 0.3),
    seq(0, 0.3, 0.1),
    expand = c(0, 0)
  ) +
  ggdist::theme_ggdist()

names(hfi_data)

hfi_data %>%
  select(year, countries, region, hf_score) %>%
  mutate(continent = countrycode::countrycode(countries, "country.name", "continent")) %>%
  mutate(na = naniar::any_na(hf_score), .by = countries) %>%
  filter(!na) %>%
  group_by(continent, year) %>%
  summarise(
    mean_hf = mean(hf_score), 
    sd_hf = sd(hf_score),
    n_cont = n(),
    se_hf = sd_hf / sqrt(n_cont),
    upper = mean_hf + se_hf * qnorm(0.975),
    lower = mean_hf - se_hf * qnorm(0.975),
    .groups = "drop"
    ) %>%
  filter(!continent == "Oceania") %>%
  select(year, continent, mean_hf, lower, upper) %>%
  ggplot(aes(x = year, y = mean_hf, color = continent, group = continent, fill = continent)) + 
  geom_path() + 
  geom_ribbon(
    aes(ymin = lower, ymax = upper),
    alpha = 0.1,
    color = NA
    ) + 
  jcolors::scale_color_jcolors(palette = "pal8") +
  jcolors::scale_fill_jcolors(palette = "pal8") +
  scale_y_continuous(
    limits = c(5, 9),
    expand = c(0, 0)
  ) +
  scale_x_continuous(
    limits = c(2000, 2020),
    breaks = seq(2000, 2020, 5),
  ) +
  ggdist::theme_ggdist()



  
  


# slopegraph example

plot_data <- hfi_data %>%
  select(year, countries, region, hf_score) %>%
  filter(year %in% seq(2000, 2020, 10)) %>%
  group_by(region, year) %>%
  summarise(mean_hf = round(mean(hf_score, na.rm = TRUE), 2)) %>%
  ungroup() 
  
region_data <- plot_data %>%
  filter(year %in% c(2000, 2020)) %>%
  mutate(region = str_wrap(region, 15)) %>%
  mutate(year = if_else(year == 2000, 1993, 2027)) %>%
  select(region, year, mean_hf)
  
coord_data <- tibble(
  y = seq(5, 9, 0.5),
  xmin = 2000,
  xmax = 2020
) %>%
  pivot_longer(c(xmin, xmax))


coord_label <- tibble(
  x = 2020,
  y = seq(5, 9),
  label = y
)

ggplot(
  data = plot_data,
  aes(x = year, y = mean_hf, color = region, group = region)
  ) + 
  geom_line(
    data = coord_data, 
    aes(y = y, x = value, group = y), 
    inherit.aes = FALSE,
    linewidth = 0.25,
    alpha = 0.5,
    linetype = "dashed"
    ) + 
  geom_label(
    data = coord_label,
    aes(x = x, y = y, label = label),
    inherit.aes = FALSE,
    family = "ssp",
    fill = "white",
    color = "grey15",
    size = 2.75,
    label.size = NA
  ) +
  geom_path(show.legend = FALSE, linewidth = 0.8) + 
  geom_text_repel(
    aes(label = mean_hf), 
    size = 3, 
    family = "ssp",
    direction = "y",
    seed = 42,
    show.legend = FALSE,
    box.padding = 0.2
    ) + 
  geom_text(
    aes(label = year, y = 9.2),
    color = "black", 
    family = "ssp"
    ) + 
  geom_text_repel(
    data = region_data, 
    aes(label = region, x = year, y = mean_hf), 
    color = "grey15",
    size = 3,
    family = "ssp",
    direction = "y",
    box.padding = 0.3,
    hjust = "left",
    force = 1
    ) +
  ggsci::scale_color_jco() + 
  theme_void() + 
  ggtitle("**Human freedom index** over the past *decades* in different *regions* of the world") + 
  theme(
    text = element_text(family = "ssp"),
    plot.title = element_textbox(
      hjust = 0.5,
      width = unit(1, "npc"),
      margin = margin(b = 5, t = 10),
      size = 14,
      family = "ssp",
      lineheight  = unit(1.2, "cm")
      ),
    plot.margin = margin(b = 5, t = 0, l = 15, r = 15)
    )


ggsave("materials/plot_examples/slopegraph_example.pdf", width = 5, height = 7)  
  
  




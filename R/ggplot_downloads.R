pacman::p_load(tidyverse, cranlogs, showtext, sysfonts, lubridate)
font_add_google("Source Sans Pro", "ssp")
showtext_auto()

ggplot2_downloads <- cran_downloads(
  packages = "ggplot2",
  from = "2012-01-01"
) %>%
  as_tibble() %>%
  select(-package)

ggplot2_downloads %>%
  mutate(cum_count = cumsum(count)) %>%
  ggplot(aes(x = date, y = cum_count)) + 
  geom_path(
    linewidth = 0.7,
    color = "darkorange3",
    ) + 
  annotate(
    geom = "text", 
    x = ymd("2019-06-01"),
    y = 1e8,
    label = "über 100 Millionen\nDownloads",
    hjust = 0,
    family = "ssp",
    size = 3.5,
    color = "grey10"
    ) +
  scale_y_continuous(
    name = "Kumulierte Anzahl an Downloads",
    expand = c(0, 0),
    labels = scales::label_number(),
    breaks = seq(0, 1.25e8, 2.5e7),
    limits = c(0, 1.25e8)
  ) +
  scale_x_date(
    name = NULL,
    date_breaks = "2 years",
    date_labels = "%Y",
  ) + 
  ggdist::theme_ggdist() + 
  theme(
    text = element_text(family = "ssp"),
    axis.title = element_text(face = "bold"),
    plot.margin = margin(rep(10, 4))
    )

ggsave("img/ggplot2_downloads.pdf", width = 6, height = 5)


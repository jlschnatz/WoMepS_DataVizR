
cleaned_data %>%
  group_by(subj_schichteinstufung) %>%
  mutate(mean_pd = mean(psychological_distress, na.rm = TRUE)) %>%
  filter(!is.na(subj_schichteinstufung)) %>%
  drop_na(psychological_distress) %>%
  ggplot(
    data = .,
    aes(y = fct_reorder(subj_schichteinstufung, mean_pd), x = psychological_distress)
  ) + 
  ggdist::stat_interval(
    show.legend = FALSE,
    .width = c(0.25, 0.5, 0.75, 0.9, 0.95, 0.99)
  ) +
  stat_summary(fun = "mean") +
  stat_summary(fun.data = "mean_cl_normal") +
  rcartocolor::scale_color_carto_d(palette = "Peach")  +
  theme_minimal()


cleaned_data %>%
  drop_na(nettoeinkommen_frei, psychological_distress) %>%
  mutate(bmi = as.numeric(as.character(bmi))) %>%
  ggplot(aes(x = lebenszufriedenheit,  y = psychological_distress)) + 
  geom_point() +
  geom_smooth(method = "lm") 

cleaned_data %>%
  drop_na(lebenszufriedenheit, psychological_distress) %>%
  mutate(lebenszufriedenheit = as.factor(lebenszufriedenheit)) %>%
  select(lebenszufriedenheit, psychological_distress) %>%
  ggplot(., aes(
    y = lebenszufriedenheit, 
    x = psychological_distress,
    fill = 0.5 - abs(0.5 - stat(ecdf))
  )) +  
  ggridges::stat_density_ridges(
    geom = "density_ridges_gradient", calc_ecdf = TRUE,
    scale = 1, 
    rel_min_height = 0.01
  )  +
  scale_fill_viridis_c(direction = -1) +
  #  geom_jitter(alpha = 0.1, width = 0.25) + 
  theme_minimal()

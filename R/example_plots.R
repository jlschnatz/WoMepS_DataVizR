library(tidyverse)
library(here)

exercise_data <- read_rds(here("data/exercise_data/clean_exercise_data.rds"))
glimpse(exercise_data)

## scatterplot

# mit ausreißern
ggplot(
  data = exercise_data,
  mapping = aes(x = nettoeinkommen_frei,
                y = aequivalenzeinkommen)
  ) + 
  geom_point()

# ohne ausreißer

exercise_data %>%
  filter(aequivalenzeinkommen <= 15000,
         nettoeinkommen_frei  <= 15000
         ) %>%
  ggplot(
    data = .,
    mapping = aes(x = nettoeinkommen_frei,
                  y = aequivalenzeinkommen)
    ) + 
  geom_point()

ggplot(
  data = exercise_data,
  mapping = aes(x = alter,
                y = bmi)
  ) +
  geom_point()  


ggplot(
  data = exercise_data,
  mapping = aes(x = alter,
                y = bmi,
                color = geschlecht)
) + 
  geom_point()


ggplot(
  data = exercise_data,
  mapping = aes(x = alter,
                y = bmi)
                
  ) + 
  geom_point() + 
  facet_grid(cols = vars(geschlecht)) 

ggplot(
  data = exercise_data,
  mapping = aes(x = alter,
                y = bmi,
                color = geschlecht)
) + 
  geom_point() + 
  facet_grid(cols = vars(geschlecht)) 


# für lineplot: hfi-daten?

## boxplot

ggplot(
  data = exercise_data,
  aes(y = psychological_distress)) +
  geom_boxplot()

ggplot(
  data = exercise_data,
  mapping = aes(x = subj_schichteinstufung,
                y = psychological_distress)
  ) + 
  geom_boxplot()
  


## barplot:

ggplot(
  data = exercise_data,
  mapping = aes(x = subj_schichteinstufung)
  ) + 
  geom_bar(stat = "count")

ggplot(
  data = exercise_data,
  mapping = aes(x = subj_schichteinstufung,
                y = after_stat(count/sum(count)))
  ) + 
  geom_bar()

# äquivalenz:

exercise_data %>%
  count(subj_schichteinstufung) %>%
  mutate(rel_h = n / sum(n)) %>%
  ggplot(
    data = .,
    mapping = aes(x = subj_schichteinstufung, y = rel_h)
  ) + 
  geom_bar(stat = "identity")


## coordinates + themes:

# von dem
p <- ggplot(
  data = exercise_data,
  mapping = aes(x = alter,
                y = bmi,
                color = geschlecht)
) + 
  geom_point(alpha = 0.7) + 
  facet_grid(cols = vars(geschlecht)) 

print(p)

p_scales <- p + 
  scale_x_continuous(
    name = "Alter",
    limits = c(18, 100),
    breaks = seq(20, 100, 10)
    ) + 
  scale_y_continuous(
    name = "Body-Mass-Index (BMI)",
    limits = c(10, 60),
    breaks = seq(10, 60, 5)
  )

print(p_scales)

p_color <- p_scales + 
  scale_color_manual(values = c("indianred3", "lightgoldenrod3")) 
  

p_color + 
  guides(color = "none") +
  ggtitle(label = "Zusammenhang zwischen Alter, BMI und Geschlecht") +
  theme_light() + 
  theme(axis.title = element_text(face = "bold"),
        axis.title.x = element_text(margin = margin(t = 10)),
        axis.title.y = element_text(margin = margin(r = 10)),
        plot.title = element_text(face = "bold", margin = margin(b = 10)))


# advanced
exercise_data %>%
  drop_na(psychological_distress, geschlecht, subj_schichteinstufung) %>%
  ggplot(
  data = .,
  mapping = aes(x = geschlecht, y = psychological_distress, color = geschlecht)
) + 
  geom_boxplot() + 
  facet_wrap(~subj_schichteinstufung) + 
  scale_y_continuous(
    name = "Psychological Distress",
    limits = c(10, 60),
    breaks = seq(10, 60, 10),
    expand = c(0, 0)
  ) + 
  scale_x_discrete(
    name = "Geschlecht",
    labels = c("Männlich", "Weiblich")
  ) + 
  scale_color_manual(values = c("indianred3", "lightgoldenrod3")) +
  theme_light()


exercise_data %>%
  ggplot(aes(x = geschlecht, y = psychological_distress, color = geschlecht)) + 
  stat_summary(fun.data  = mean_cl_normal, geom = "pointrange") +
  facet_wrap(~ost_west) +
  scale_color_manual(values = c("indianred3", "lightgoldenrod3")) +
  theme_light()

exercise_data %>%
  filter(nettoeinkommen_frei <= 5000) %>%
ggplot(
  data = .,
  mapping = aes(x = nettoeinkommen_frei, 
                y = factor(lebenszufriedenheit))
) +   
  ggridges::geom_density_ridges(
    scale = 0.9
  )  +
  stat_summary(fun = "mean") + 
  theme_light()



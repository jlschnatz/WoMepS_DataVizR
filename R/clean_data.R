library(tidyverse)
library(here)

change_data_type <- function(data, metadata) {
  data_type_functions <- list(
    numeric = as.numeric,
    factor = as.factor,
    integer = as.integer
  )
  output <- data %>%
    map2_dfc(
      metadata$data_type,
      ~ data_type_functions[[.y]](.x)
    )
  return(output)
}

new_varnames <- c(
  "id_participant", "geschlecht", "alter", "familienstand",
  "nettoeinkommen_frei", "nettoeinkommen_binned", "aequivalenzeinkommen",
  "konfession", "erwerb_1", "erwerb_2",
  "schulabschluss", "berufstaetig", "berufliche_stellung",
  "staatsbuergerschaft", "deutsch_staats", "bundesland",
  "ost_west", "subj_schichteinstufung", "bmi",
  "ps_01_gehetzt", "ps_02_niedergeschlagen", "ps_03_ausgeglichen",
  "ps_04_energetisch", "ps_05_schmerzen", "ps_06_einsam",
  "ps_07_gesundeinschr_koerperlich_allg",
  "ps_08_gesundeinschr_koerperlich_art",
  "ps_09_gesundeinschr_seelisch_allg",
  "ps_10_gesundeinschr_seelisch_art",
  "ps_11_einschr_sozial",
  "lebenszufriedenheit"
)


metadata <- read_tsv(here("data/exercise_data/exercise_metadata.tsv")) %>%
  rename(
    var_id = `Dataset name`,
    var_name = `Variable name`
  )

exercise_data <- read_csv(here("data/exercise_data/exercise_data.csv"))

cleaned_data <- exercise_data %>%
  mutate(across(where(is.character), str_to_lower)) %>%
  change_data_type(., metadata) %>%
  rename_with(~new_varnames) %>%
  mutate(lebenszufriedenheit = case_when(
    lebenszufriedenheit == "ganz unzufrieden" ~ "0",
    lebenszufriedenheit == ".." ~ "1",
    lebenszufriedenheit == "ganz zufrieden" ~ "10",
    TRUE ~ lebenszufriedenheit
  )) %>%
  mutate(lebenszufriedenheit = if_else(
    condition = str_detect(lebenszufriedenheit, "duplicated"),
    true = as.character(str_extract_all(lebenszufriedenheit, "duplicated_[0-9]")),
    false = lebenszufriedenheit
  )) %>%
  mutate(lebenszufriedenheit = as.numeric(parse_number(lebenszufriedenheit))) %>%
  mutate(across(
    .cols = starts_with("ps_"),
    .fns = ~factor(.x, levels = c("nie", "fast nie", "manchmal", "oft", "immer")))
    ) %>%
  mutate(across(starts_with("ps_"), as.integer)) %>%
  mutate(across(
    c(ps_03_ausgeglichen, ps_04_energetisch),
    ~ as.integer(6 - .x))
    ) %>%
  rowwise() %>%
  mutate(psychological_distress = sum(c_across(starts_with("ps_")))) %>%
  ungroup() %>%
  mutate(across(c(nettoeinkommen_frei, aequivalenzeinkommen, bmi), ~as.numeric(as.character(.x)))) %>%
  mutate(subj_schichteinstufung = factor(subj_schichteinstufung, labels = c(
    "unterschicht", "arbeiterschicht",
    "mittelschicht", "oberemittelschicht",
    "oberschicht", "keine der schichten")
    ))
  
glimpse(cleaned_data)
write_rds(x = cleaned_data, file = here("data/exercise_data/clean_exercise_data.rds"))






  
  



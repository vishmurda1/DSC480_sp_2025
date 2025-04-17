

library(readr)
library(dplyr)
library(stringr)
report <- read_csv("2025_02_18_utilization_report.csv")

unicare <- report %>% filter(str_detect(org_name, "Unicare")) %>%
  select(org_name, total_ibis_inpatient, c(alzheimers:urologic_cancer)) %>% 
  mutate(total_inpatient = total_ibis_inpatient) %>% 
  select(-total_ibis_inpatient)

miia <- report %>% filter(str_detect(org_name, "MIIA")) %>%
  select(org_name, total_pre_ibis_inpatient, c(alzheimers:urologic_cancer)) %>% 
  mutate(total_inpatient = total_pre_ibis_inpatient) %>% 
  select(-total_pre_ibis_inpatient)

unicare_miia <- unicare %>% bind_rows(miia) %>% 
  mutate(org_name = if_else(str_detect(org_name, "Unicare"), "Unicare", "MIIA"))

write_csv(unicare_miia, "unicare_miia.csv")

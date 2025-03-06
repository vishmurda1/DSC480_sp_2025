source("read_clean.R")


events_full %>% filter(org_name == "Unicare - Study") %>% 
  filter(event_start_date > ibis_coverage_end_date) %>% 
  summarize(mean(ibis_er))

#events_full %>% filter(org_name = "Unicare - Study") %>% 
  
  
  

  
events_full %>% filter(org_name == "Unicare - Study") %>% 
  filter(event_start_date > ibis_coverage_start_date &
           event_start_date < ibis_coverage_end_date) %>%
  summarize(count = n())

ibis_inpatient_table <- events_full %>% 
  filter(pre_ibis_inpatient == 1|event_type == "no_utilization") %>% 
  group_by(pid, event_type) %>% 
  summarize(count = n(), .groups = "drop") %>% 
  pivot_wider(names_from = event_type, values_from = count) %>% 
replace(is.na(.), 0) %>% rename(ibis_inpatient_count = inpatient) %>% view()
  

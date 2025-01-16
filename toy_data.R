
## This takes the data and shuffles the row values for each column separately.
library(tidyverse)

report_toy <- report |> mutate(across(everything(), ~sample(.x)))
events_toy <- events |> mutate(across(everything(), ~sample(.x)))

write_csv(report_toy, "report_toy.csv")
write_csv(events_toy, "events_toy.csv")

## put a comment

## more text


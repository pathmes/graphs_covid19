library(tidyverse)
library(lubridate)
library(readr)
library(utils)

ecdata <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
                   na.strings = "", fileEncoding = "UTF-8-BOM")

ecdata <- as_tibble(ecdata)

ecdata$dateR <- dmy(ecdata$dateRep)

ecdata <- ecdata %>% group_by(countriesAndTerritories) %>% 
  mutate(cum.cases = order_by(dateR, cumsum(cases))) 

ecdata <- ecdata %>% group_by(countriesAndTerritories) %>% 
  mutate(cum.deaths = order_by(dateR, cumsum(deaths)))


saveRDS(ecdata, "ecdc/ecdata.rds")


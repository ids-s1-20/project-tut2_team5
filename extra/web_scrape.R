#Web scraping (if allowed) will shortcut some defensive stats calculation (and 
#offensive stat calculation as well, but we could theoretically do the offensive
#stats ourselves, so this is mostly about getting DRS, UZR, TZ, etc.)

library(tidyverse)
library(rvest)
library(robotstxt)

paths_allowed("https://www.fangraphs.com/teams/athletics/stats?season=2019")

#paths_allowed returns TRUE
#URL format as follows
# "https://www.fangraphs.com/teams/" + [team name] + "/stats?season=" + [year]

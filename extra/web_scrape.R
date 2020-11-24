#Web scraping (if allowed) will shortcut some defensive stats calculation (and 
#offensive stat calculation as well, but we could theoretically do the offensive
#stats ourselves, so this is mostly about getting DRS, UZR, TZ, etc.)

library(tidyverse)
library(rvest)
library(robotstxt)
library(glue)

paths_allowed("https://www.fangraphs.com/teams/athletics/stats?season=2019")

#paths_allowed returns TRUE
#URL format as follows
# "https://www.fangraphs.com/teams/" + [team name] + "/stats?season=" + [year]

years <- glue("/stats?season={(1998:2019)}")
  
teams <- read_html("https://www.fangraphs.com/teams/") %>%
  html_nodes(".select-change-team") %>%
  html_children() %>%
  html_attr("value") %>% #e.g. "/teams/angels"
  str_squish() %>%
  na.omit() #removes first case which is "Select Team" 
  

if(length(teams) != 30){
  stop("The number of teams should be 30. Check if the page is still up!")
}

root <- "https://www.fangraphs.com"

# 30 x 22 where each col is a season
urls <- outer(teams, years, FUN = "paste0")
colnames(urls) <- 1998:2019 #so we can access season by year but as A STRING!

#season_urls <- paste0("https://www.fangraphs.com", urls[,season])

col_names <- read_html(paste0("https://www.fangraphs.com", urls[1])) %>%
  html_nodes("thead") %>%
  tail(n = 1) %>%
  html_nodes("th") %>% 
  html_text() %>%
  str_squish

col_names[-1]
  
get_team_field<- function(url){
  
  stats <- read_html(paste0("https://www.fangraphs.com", url)) %>%
    html_nodes("tfoot") %>%
    tail(n = 1) %>% #fielding is last in the website
    html_nodes("td") %>% 
    html_text() %>%
    str_squish
  
  stats[-1]
  
}

#most teams dont have fielding stats recorded before 2002



fielding <- map_dfr(urls, get_team_field)
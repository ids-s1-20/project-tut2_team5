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


# Here we are just generating the links

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



# Now we get the actual data

COL_NAMES <- c("team", "season", "pos", "g", "gs", "inn", "po", 
               "a", "drs", "arm", "dpr", "rngR", "errR", "uzr", 
               "uzr150", "def")


get_team_field<- function(url){
  
  #Get the team and season by matching w/ Regex
  team_name <- str_replace(str_extract(url, "(?<=s\\/).+(?=\\/s)"), "-", "_")
  season_year <- str_extract(url, "(?<=season=).+")
  
  
  stats <- rep(NA, 14)
  
  tryCatch(
    expr = { 
      stats <- read_html(paste0(root, url)) %>%
        html_nodes("tfoot") %>%
        tail(n = 1) %>% #fielding is last in the website
        html_nodes("td") %>% 
        html_text() %>%
        tail(-1) %>% #removes "Team Total"
        str_squish()
    },
    error = function(e){ #deals with HTTP error 500 i.e. Nationals 1998
      message(e[1])
      print(paste(team_name, season_year))
      #helps me see what is happening
    }
  )
  
  #the website gets a CAPTCHA wall if you request a lot
  if(length(stats) == 0){
    m <- "N"
    while(m != "y"){
      print("You need to complete the Captcha to continue!")
      m <- readline(prompt = "type y after doing the Captcha:")
    }
    
    stats <- get_team_field(url)
  }
  
  
  stats <- c(team_name, season_year, stats)
  names(stats) <- COL_NAMES
  
  stats
  
}


#most teams don't have fielding stats recorded before 2002
#rays do not have nothing until 2008
#nationals do not have nothing until 2005


fielding <- map_dfr(urls, get_team_field)


write_csv(fielding, file="../data/fielding.csv")
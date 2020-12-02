#Web scraping (if allowed) will shortcut some defensive stats calculation (and 
#offensive stat calculation as well, but we could theoretically do the offensive
#stats ourselves, so this is mostly about getting DRS, UZR, TZ, etc.)

library(tidyverse)
library(rvest)
library(robotstxt)
library(glue)

#assert that webscraping is allowed
if(!paths_allowed("https://www.fangraphs.com")){
  stop("Webscraping not allowed by website!")
}


#paths_allowed returns TRUE
#URL format as follows
# "https://www.fangraphs.com/teams/" + [team name] + "/stats?season=" + [year]

###########################################################################
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


###########################################################################
# Now we get the actual data



#most teams don't have fielding stats recorded before 2002
#rays do not have nothing until 2008
#nationals do not have nothing until 2005


#gets fielding stats for each player from the url
get_player_field<- function(url){
  
  #Get the team and season by matching w/ Regex
  team_name <- str_replace(str_extract(url, "(?<=s\\/).+(?=\\/s)"), "-", "_")
  season_year <- str_extract(url, "(?<=season=).+")
  
  stats <- rep(NA, 17)
  
  tryCatch(
    
    expr = { 
      stats <- read_html(paste0(root, url)) %>%
        html_nodes("table") %>%
        html_table() %>%
        nth(11) %>% #11th table is for fielding
        head(-1) %>% #removes Team Total
        mutate(team = team_name, season = season_year)
      
      return(stats)
    },
    
    error = function(e){ #deals with HTTP error 500 i.e. Nationals 1998
      if(e[1] == "HTTP error 500."){ #i.e. page does not exist
        
        print(paste(team_name, season_year)) #make sure it is rays or nationals
        return()
        
      }else{#the website gets a CAPTCHA wall if you request a lot
        #this error should be from mutate
        print(e[1])
        m <- "N"
        message(e) #ensure it is not another type of error
        print(paste(team_name, season_year)) #so I can check later
        while(m != "y"){
          print("You need to complete the Captcha to continue!")
          m <- readline(prompt = "type y after doing the Captcha:")
        }
        
        stats <- get_player_field(url)
        return(stats)
      }
    }
    
    
  )
  
}

player_fielding <- map_dfr(urls, get_player_field)

#rearranging cols. so team and season are in front
player_fielding <- player_fielding[, c(16, 17, 1:15)]

#renaming to snake_case
COL_NAMES <- c("team", "season", "name", "pos", "g", "gs", "inn", "po", 
               "a", "drs", "arm", "dpr", "rng_r", "err_r", "uzr", 
               "uzr150", "def")
names(player_fielding) <- COL_NAMES

#finally saving
write_csv(player_fielding, file="../data/player-fielding.csv")


#Similarly for batting,

#gets fielding stats for each player from the url
get_player_bat <- function(url){
  
  #Get the team and season by matching w/ Regex
  team_name <- str_replace(str_extract(url, "(?<=s\\/).+(?=\\/s)"), "-", "_")
  season_year <- str_extract(url, "(?<=season=).+")
  
  
  tryCatch(
    
    expr = { 
      stats <- read_html(paste0(root, url)) %>%
        html_nodes("table") %>%
        html_table() %>%
        nth(8) %>% #8th table is for batting
        head(-1) %>% #removes Team Total
        mutate(team = team_name, season = season_year)
      
      return(stats)
    },
    
    error = function(e){ #deals with HTTP error 500 i.e. Nationals 1998
      if(e[1] == "HTTP error 500."){ #i.e. page does not exist
        
        print(paste(team_name, season_year)) #make sure it is rays or nationals
        return()
        
      }else{#the website gets a CAPTCHA wall if you request a lot
        #this error should be from mutate
        print(e[1])
        m <- "N"
        message(e) #ensure it is not another type of error
        print(paste(team_name, season_year)) #so I can check later
        while(m != "y"){
          print("You need to complete the Captcha to continue!")
          m <- readline(prompt = "type y after doing the Captcha:")
        }
        
        stats <- get_player_bat(url)
        return(stats)
      }
    }
    
  )
  
}

player_batting <- map_dfr(urls, get_player_bat)

#rearranging cols. so team and season are in front
player_batting <- player_batting[, c(20, 21, 1:19)]

#renaming to snake_case
COL_NAMES <- c("team", "season", "name", "age", "g", "pa", "hr", "sb", 
               "bb", "k", "iso", "babip", "avg", "obp", "slg", 
               "w_oba", "w_rc", "bsr", "off", "def", "war")
names(player_batting) <- COL_NAMES

#finally saving
write_csv(player_batting, file="../data/player-batting.csv")
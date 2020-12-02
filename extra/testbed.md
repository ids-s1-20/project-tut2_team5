Project testbed
================
A. Warren

``` r
#Starting with fielding
fielding <- read_csv("/cloud/project/data/player-fielding.csv",
                     col_types = cols(drs = col_integer(), 
                                      arm = col_double(), 
                                      dpr  = col_double(),
                                      rng_r  = col_double(),
                                      err_r  = col_double(),
                                      uzr  = col_double(),
                                      uzr150  = col_double(),
                                      def  = col_double(),
                                      .default = "?"))
#It initially wanted to list all the important variables as boolean lmao

#cut out duplicate outfield stats

fielding %>%
  filter(pos %in% c("OF","1B","2B","3B","SS","C")) -> fielding_drop_dupes

#Now for teams stats. Going to take a weighted mean to account for the fact that
#some players play in more games/innings than others. Using inning since that's
#the lowest division of game participation we have. None of the stats quite take
#play time into account the way we want. UZR150, the only one that directly 
#accounts for play time, is a player's average/expected UZR over 150 games. It's
#useful for comparing two players to eachother, but what we care about is 
#overall team performance.

fielding_drop_dupes %>%
  group_by(team, season) %>%
  summarise(mean_innings = mean(inn, na.rm = TRUE),
            mean_drs = weighted.mean(drs, inn, na.rm = TRUE),
            mean_uzr = weighted.mean(uzr, inn, na.rm = TRUE),
            mean_uzr150 = weighted.mean(uzr150, inn, na.rm = TRUE),
            mean_def = weighted.mean(def, inn, na.rm = TRUE)) -> teams_fielding_messy
```

    ## `summarise()` regrouping output by 'team' (override with `.groups` argument)

``` r
#Have NaNs for the relevant stats pre-2002, and 0s for DRS in 2002, so I need to
#replace with NA. Found this package called naniar 
#https://cran.r-project.org/web/packages/naniar/ that has a function to do that 
#for me, so I'm going to try it out.

teams_fielding_messy %>%
  replace_with_na(replace = list(mean_drs = c(NaN, 0.00000000), mean_uzr = NaN, mean_uzr150 = NaN, mean_def = NaN)) -> teams_fielding

write_csv(teams_fielding, "/cloud/project/data/teams-fielding.csv")
```

``` r
batting <- read_csv("/cloud/project/data/player-batting.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   team = col_character(),
    ##   name = col_character(),
    ##   bb = col_character(),
    ##   k = col_character()
    ## )

    ## See spec(...) for full column specifications.

``` r
#minimal cleaning to do with batting data, so I can basically just copy what I 
#did for fielding. This time we weight for plate appearances. Jimmy Rollins, 
#known mostly for his superb shortstop defensive play, holds the record for 
#plate appearances in a season, at 778 in 2007

batting %>%
group_by(team, season) %>%
  summarise(mean_pa = mean(pa, na.rm = TRUE),
            mean_avg = weighted.mean(avg, pa, na.rm = TRUE),
            mean_slg = weighted.mean(slg, pa, na.rm = TRUE),
            mean_iso = weighted.mean(iso, pa, na.rm = TRUE),
            mean_babip = weighted.mean(babip, pa, na.rm = TRUE),
            mean_obp = weighted.mean(obp, pa, na.rm = TRUE),
            mean_w_oba = weighted.mean(w_oba, pa, na.rm = TRUE),
            mean_w_rc = weighted.mean(w_rc, pa, na.rm = TRUE),
            mean_bsr = weighted.mean(bsr, pa, na.rm = TRUE),
            mean_off = weighted.mean(off, pa, na.rm = TRUE),
            mean_war = weighted.mean(war, pa, na.rm = TRUE)) -> teams_batting
```

    ## `summarise()` regrouping output by 'team' (override with `.groups` argument)

``` r
write_csv(teams_batting, "/cloud/project/data/teams-batting.csv")
```

``` r
teams_source <- read_csv("/cloud/project/data/baseballdatabank-master/core/Teams.csv",
                       col_types = cols(
                         .default = col_double(),
                         lgID = col_character(),
                         teamID = col_character(),
                         franchID = col_character(),
                         divID = col_character(),
                         DivWin = col_character(),
                         WCWin = col_character(),
                         LgWin = col_character(),
                         WSWin = col_character(),
                         SF = col_character(),
                         name = col_character(),
                         park = col_character(),
                         teamIDBR = col_character(),
                         teamIDlahman45 = col_character(),
                         teamIDretro = col_character()
                       ))


teams_source %>%
  filter(yearID %in% 1998:2019) %>%
  subset(select = c(yearID, lgID, teamID, franchID, G, W, L, WSWin, name))-> teams_main

teams_batting <- read_csv("/cloud/project/data/teams-batting.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   team = col_character(),
    ##   season = col_double(),
    ##   mean_pa = col_double(),
    ##   mean_avg = col_double(),
    ##   mean_slg = col_double(),
    ##   mean_iso = col_double(),
    ##   mean_babip = col_double(),
    ##   mean_obp = col_double(),
    ##   mean_w_oba = col_double(),
    ##   mean_w_rc = col_double(),
    ##   mean_bsr = col_double(),
    ##   mean_off = col_double(),
    ##   mean_war = col_double()
    ## )

``` r
teams_fielding <- read_csv("/cloud/project/data/teams-fielding.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   team = col_character(),
    ##   season = col_double(),
    ##   mean_innings = col_double(),
    ##   mean_drs = col_double(),
    ##   mean_uzr = col_double(),
    ##   mean_uzr150 = col_double(),
    ##   mean_def = col_double()
    ## )

``` r
#Due to web scraping issues, we don't have data on Montreal Expos or Tampa Bay 
#Devil Rays. We do have data from after they rebranded to Washington Nationals 
#and Tampa Bay Rays respectively though. Will filter those out.

teams_main <- teams_main[!(teams_main$teamID == "TBA" & teams_main$yearID %in% 1998:2007),]
teams_main <- teams_main[!(teams_main$teamID == "MON"),]

#now to get team names set up in prep for join

#this is going to be extremely inelegant, but I'm only running it once so I
#don't particularly care about efficiency, I just need it to work

teams_main$name[teams_main$franchID == "ANA"] <- "angels"
teams_main$name[teams_main$franchID == "ARI"] <- "diamondbacks"
teams_main$name[teams_main$franchID == "ATL"] <- "braves"
teams_main$name[teams_main$franchID == "BAL"] <- "orioles"
teams_main$name[teams_main$franchID == "BOS"] <- "red_sox"
teams_main$name[teams_main$franchID == "CHW"] <- "white_sox"
teams_main$name[teams_main$franchID == "CHC"] <- "cubs"
teams_main$name[teams_main$franchID == "CIN"] <- "reds"
teams_main$name[teams_main$franchID == "CLE"] <- "indians"
teams_main$name[teams_main$franchID == "COL"] <- "rockies"
teams_main$name[teams_main$franchID == "DET"] <- "tigers"
teams_main$name[teams_main$franchID == "HOU"] <- "astros"
teams_main$name[teams_main$franchID == "KCR"] <- "royals"
teams_main$name[teams_main$franchID == "LAD"] <- "dodgers"
teams_main$name[teams_main$franchID == "FLA"] <- "marlins"
teams_main$name[teams_main$franchID == "MIL"] <- "brewers"
teams_main$name[teams_main$franchID == "MIN"] <- "twins"
teams_main$name[teams_main$franchID == "NYY"] <- "yankees"
teams_main$name[teams_main$franchID == "NYM"] <- "mets"
teams_main$name[teams_main$franchID == "OAK"] <- "athletics"
teams_main$name[teams_main$franchID == "PHI"] <- "phillies"
teams_main$name[teams_main$franchID == "PIT"] <- "pirates"
teams_main$name[teams_main$franchID == "SDP"] <- "padres"
teams_main$name[teams_main$franchID == "SEA"] <- "mariners"
teams_main$name[teams_main$franchID == "SFG"] <- "giants"
teams_main$name[teams_main$franchID == "STL"] <- "cardinals"
teams_main$name[teams_main$franchID == "TBD"] <- "rays"
teams_main$name[teams_main$franchID == "TEX"] <- "rangers"
teams_main$name[teams_main$franchID == "TOR"] <- "blue_jays"
teams_main$name[teams_main$franchID == "WSN"] <- "nationals"

teams_main %>%
  mutate(win_rate = W / G) %>%
  mutate(team = name) %>%
  mutate(season = yearID) %>%
  subset(select = c(team, season, win_rate, WSWin))-> teams_main

write_csv(teams_main, "/cloud/project/data/teams-performance.csv")
```

``` r
teams_perf <- read_csv("/cloud/project/data/teams-performance.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   team = col_character(),
    ##   season = col_double(),
    ##   win_rate = col_double(),
    ##   WSWin = col_character()
    ## )

``` r
teams_bat <- read_csv("/cloud/project/data/teams-batting.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   team = col_character(),
    ##   season = col_double(),
    ##   mean_pa = col_double(),
    ##   mean_avg = col_double(),
    ##   mean_slg = col_double(),
    ##   mean_iso = col_double(),
    ##   mean_babip = col_double(),
    ##   mean_obp = col_double(),
    ##   mean_w_oba = col_double(),
    ##   mean_w_rc = col_double(),
    ##   mean_bsr = col_double(),
    ##   mean_off = col_double(),
    ##   mean_war = col_double()
    ## )

``` r
teams_field <- read_csv("/cloud/project/data/teams-fielding.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   team = col_character(),
    ##   season = col_double(),
    ##   mean_innings = col_double(),
    ##   mean_drs = col_double(),
    ##   mean_uzr = col_double(),
    ##   mean_uzr150 = col_double(),
    ##   mean_def = col_double()
    ## )

``` r
full_join(teams_perf, teams_bat) %>%
  full_join(teams_field) -> teams_cleaned
```

    ## Joining, by = c("team", "season")

    ## Joining, by = c("team", "season")

``` r
write_csv(teams_cleaned, "/cloud/project/data/teams-cleaned.csv")
```

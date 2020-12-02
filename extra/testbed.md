Project testbed
================
A. Warren (theoretically other members of tut2\_team5 as well, but I’ll
leave it to them to add their names if they end up doing any work on
this particular rmd)

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

#write_csv(teams_fielding, file = "/cloud/project/data/teams-fielding.csv")
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

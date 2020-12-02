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

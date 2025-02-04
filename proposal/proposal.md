Project proposal
================
tut2\_team5

## 1\. Introduction

> *“I made baseball as much fun as doing your taxes.”*
> 
>   - Bill James, father of modern Sabermetrics (The Simpsons S22E03
>     “MoneyBART”)

Statistical study of baseball (also known as Sabermetrics or
SABRmetrics) has become an increasingly popular tool both for fans
seeking to understand the game and for organizations seeking to optimize
their rosters and build better teams. Our group will look at how
effectively different measurements for evaluating individual player
performance predict team success.

The datasets we are going to use were compiled by an organization
Chadwick Baseball Bureau. From their
[webpage](http://chadwick-bureau.com/): “Chadwick Baseball Bureau was
founded to support baseball professionals and analysts by providing tidy
baseball data. We create value for our clients and for the community by
allowing users to focus on understanding and acting on information,
rather than spending their time compiling and integrating it.” The CBB
dataset includes data from [Retrosheet](http://retrosheet.org/), another
organization dedicated to providing baseball data. Much of this compiled
data was originally collected from MLB teams and the league itself, with
other sources such as sportswriters contributing to game data.

In the course of this project we won’t cover data from before the league
and teams started keeping computer records, so the data we cover will
entirely originate from these official records.

## 2\. Data

Information regarding the licensing of this data can be found in
`/project/data/baseballdatabank-master/README.txt`

The dataset is large and is composed of 29 csv files. For convenience,
I’ll only include a skim of player data joined with batting data.

|                                                  |               |
| :----------------------------------------------- | :------------ |
| Name                                             | batting\_demo |
| Number of rows                                   | 107830        |
| Number of columns                                | 45            |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |               |
| Column type frequency:                           |               |
| character                                        | 16            |
| Date                                             | 2             |
| numeric                                          | 27            |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |               |
| Group variables                                  | None          |

Data summary

**Variable type: character**

| skim\_variable | n\_missing | complete\_rate | min | max | empty | n\_unique | whitespace |
| :------------- | ---------: | -------------: | --: | --: | ----: | --------: | ---------: |
| playerID       |          0 |           1.00 |   5 |   9 |     0 |     20090 |          0 |
| birthCountry   |         70 |           1.00 |   3 |  14 |     0 |        57 |          0 |
| birthState     |       3022 |           0.97 |   2 |  22 |     0 |       296 |          0 |
| birthCity      |        393 |           1.00 |   3 |  26 |     0 |      4884 |          0 |
| deathCountry   |      61016 |           0.43 |   3 |  14 |     0 |        25 |          0 |
| deathState     |      61223 |           0.43 |   2 |  20 |     0 |       107 |          0 |
| deathCity      |      61041 |           0.43 |   2 |  26 |     0 |      2671 |          0 |
| nameFirst      |         38 |           1.00 |   2 |  14 |     0 |      2529 |          0 |
| nameLast       |          0 |           1.00 |   2 |  14 |     0 |     10238 |          0 |
| nameGiven      |         38 |           1.00 |   2 |  43 |     0 |     13337 |          0 |
| bats           |       2024 |           0.98 |   1 |   1 |     0 |         3 |          0 |
| throws         |       1580 |           0.99 |   1 |   1 |     0 |         3 |          0 |
| retroID        |         56 |           1.00 |   8 |   8 |     0 |     20034 |          0 |
| bbrefID        |          2 |           1.00 |   5 |   9 |     0 |     20088 |          0 |
| teamID         |        401 |           1.00 |   3 |   3 |     0 |       149 |          0 |
| lgID           |       1139 |           0.99 |   2 |   2 |     0 |         6 |          0 |

**Variable type: Date**

| skim\_variable | n\_missing | complete\_rate | min        | max        | median     | n\_unique |
| :------------- | ---------: | -------------: | :--------- | :--------- | :--------- | --------: |
| debut          |        198 |              1 | 1871-05-04 | 2020-09-27 | 1970-09-12 |     10572 |
| finalGame      |        198 |              1 | 1871-05-05 | 2020-09-27 | 1981-09-29 |      9479 |

**Variable type: numeric**

| skim\_variable | n\_missing | complete\_rate |    mean |     sd |   p0 |  p25 |  p50 |  p75 | p100 | hist  |
| :------------- | ---------: | -------------: | ------: | -----: | ---: | ---: | ---: | ---: | ---: | :---- |
| birthYear      |        151 |           1.00 | 1938.46 |  39.20 | 1820 | 1907 | 1948 | 1971 | 2000 | ▁▃▅▇▇ |
| birthMonth     |        511 |           1.00 |    6.65 |   3.45 |    1 |    4 |    7 |   10 |   12 | ▇▅▅▆▇ |
| birthDay       |        860 |           0.99 |   15.67 |   8.73 |    1 |    8 |   16 |   23 |   31 | ▇▇▇▇▆ |
| deathYear      |      60988 |           0.43 | 1971.18 |  32.41 | 1872 | 1949 | 1973 | 1998 | 2020 | ▁▃▅▇▇ |
| deathMonth     |      60989 |           0.43 |    6.50 |   3.53 |    1 |    3 |    7 |   10 |   12 | ▇▅▅▅▇ |
| deathDay       |      60991 |           0.43 |   15.45 |   8.82 |    1 |    8 |   15 |   23 |   31 | ▇▆▇▆▆ |
| weight         |       1227 |           0.99 |  188.95 |  22.83 |   65 |  175 |  185 |  200 | 2125 | ▇▁▁▁▁ |
| height         |       1155 |           0.99 |   72.48 |   2.54 |   43 |   71 |   72 |   74 |   83 | ▁▁▁▇▁ |
| yearID         |        401 |           1.00 | 1966.55 |  39.55 | 1871 | 1936 | 1976 | 2000 | 2019 | ▂▃▃▆▇ |
| stint          |        401 |           1.00 |    1.08 |   0.29 |    1 |    1 |    1 |    1 |    5 | ▇▁▁▁▁ |
| G              |        401 |           1.00 |   51.13 |  47.02 |    1 |   12 |   34 |   80 |  165 | ▇▃▂▂▂ |
| AB             |        401 |           1.00 |  140.45 | 184.29 |    0 |    4 |   47 |  228 |  716 | ▇▁▁▁▁ |
| R              |        401 |           1.00 |   18.64 |  28.16 |    0 |    0 |    4 |   27 |  198 | ▇▁▁▁▁ |
| H              |        401 |           1.00 |   36.71 |  52.40 |    0 |    0 |    8 |   57 |  262 | ▇▁▁▁▁ |
| 2B             |        401 |           1.00 |    6.25 |   9.67 |    0 |    0 |    1 |    9 |   67 | ▇▁▁▁▁ |
| 3B             |        401 |           1.00 |    1.26 |   2.61 |    0 |    0 |    0 |    1 |   36 | ▇▁▁▁▁ |
| HR             |        401 |           1.00 |    2.86 |   6.40 |    0 |    0 |    0 |    2 |   73 | ▇▁▁▁▁ |
| RBI            |       1157 |           0.99 |   16.93 |  26.34 |    0 |    0 |    3 |   24 |  191 | ▇▁▁▁▁ |
| SB             |       2769 |           0.97 |    2.95 |   7.65 |    0 |    0 |    0 |    2 |  138 | ▇▁▁▁▁ |
| CS             |      23942 |           0.78 |    1.19 |   2.70 |    0 |    0 |    0 |    1 |   42 | ▇▁▁▁▁ |
| BB             |        401 |           1.00 |   12.95 |  20.68 |    0 |    0 |    2 |   18 |  232 | ▇▁▁▁▁ |
| SO             |       2501 |           0.98 |   20.68 |  28.61 |    0 |    1 |    9 |   29 |  223 | ▇▁▁▁▁ |
| IBB            |      37052 |           0.66 |    1.07 |   2.73 |    0 |    0 |    0 |    1 |  120 | ▇▁▁▁▁ |
| HBP            |       3218 |           0.97 |    1.06 |   2.30 |    0 |    0 |    0 |    1 |   51 | ▇▁▁▁▁ |
| SH             |       6470 |           0.94 |    2.23 |   4.18 |    0 |    0 |    0 |    3 |   67 | ▇▁▁▁▁ |
| SF             |      36505 |           0.66 |    1.04 |   1.94 |    0 |    0 |    0 |    1 |   19 | ▇▁▁▁▁ |
| GIDP           |      25842 |           0.76 |    2.93 |   4.70 |    0 |    0 |    0 |    4 |   36 | ▇▁▁▁▁ |

## 3\. Data analysis plan

We will look at the effectiveness of different player stats in
predicting team success. To begin with, the dataset only includes basic
statistics. Most of the stats we’re interested in (OBP, OPS, wOBA, wRC,
wRAA, etc.) will have to be calculated from these basic statistics. In
order to simplify the data, we’ll use player rosters to find mean value
and other summary statistics for each variable for each team over time.
Plotting each team’s mean value for each variable against game outcomes
to gauge strength of association should provide a starting point for
assessing the effectiveness of each variable in predicting game
outcomes. We can follow up by looking for possible confounding variables
and controlling for them (e.g. possible impact of morale on team
performance could be gauged by looking into win/loss streaks and
comparing home vs. away game performance).

If we’ve got extra time we could run the process for a few different
seasons. Conversely, if it’s too much work we might consider cutting
defensive stats since they seem like they might be a hassle to
calculate.

### Preliminary Data Analysis

From
\[Wikipedia\]\[<https://en.wikipedia.org/wiki/On-base_percentage>\]:
On-base percentage (OBP), also known as on-base average/OBA, measures
how frequently a batter reaches base.

OBP can be calculated using the following formula:

![obp](http://www.sciweavers.org/tex2img.php?eq=OBP%20%3D%20%5Cfrac%7BH%20%2B%20BB%20%2B%20HBP%7D%7BAB%20%2B%20BB%20%2B%20HBP%20%2B%20SF%7D&bc=White&fc=Black&im=png&fs=12&ff=arev&edit=0)

``` r
obps <- batting %>%
  mutate(OBP = (H + BB + HBP)/(AB + BB + HBP + SF)) %>%
  filter(!is.na(OBP)) %>%
  select(playerID, OBP) %>%
  group_by(playerID) %>% # We have the OBPs of all years instead,
  summarize(OBP = mean(OBP)) # we only want the mean of all seasons
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

After calculating OBP, we can look at its relationship with other
factors e.g. I chose number of awards given to a player from
`AwardsPlayers.csv` like this:

``` r
awards <- read_csv("/cloud/project/data/baseballdatabank-master/core/AwardsPlayers.csv",
                   col_types = cols(tie = col_character(), 
                                     .default = "?"))

num_awards <- count(awards, playerID)
```

and then we could merge the two columns by playerID (awards & obp).

``` r
obp_awards <- merge(obps, num_awards)

#remove the entry that has OBP 1 bc it is impossible 
#highest ever was .48
obp_awards <- obp_awards %>%
  filter(0 < OBP && OBP < .5)
```

Finally, we could plot them together to visualise the relationship.

``` r
ggplot(obp_awards, aes(x = OBP, y = n)) + 
  ggtitle("OBP Against Number of Awards Recieved") +
  ylab("Number of Awards Recieved") + 
  geom_point(size = 1.2, alpha = 0.35)
```

![](proposal_files/figure-gfm/plot-obp-awards-1.png)<!-- -->

Datasets below are retrieved from [here](http://chadwick-bureau.com/).
Read more about licensing and more in `README.txt`


## People.csv

20,090 entries x 24 variables

- `playerID` : Used to identify each player. In the format first name +
               surname initial + two digit number for duplicates e.g. "mohamada01"

- `birthYear` : Birth year e.g. 1982

- `birthMonth` : Birth month e.g. 12 for December

- `birthDay` : Birth month e.g. 25

- `birthCountry`: Country of Birth e.g. "USA" or "D.R."

- `birthState`: Two letter code for US state e.g. "NY" or part of the country if
                player is born outside the US e.g. "Sinaloa"

- `birthCity` : Birth city e.g. "Chicago"

- `deathYear` : Death year e.g. 1984 or NA if player is still alive

- `deathMonth` : Death month e.g. 12 or NA if player is still alive

- `deathDay` : Death day e.g. 25 or NA if player is still alive

- `deathCountry` : Death country e.g. "USA" or NA if player is still alive

- `deathState` : Death state e.g. "NY"/"Sinaloa" or NA if player is still alive

- `deathCity` : Death city e.g. "Chicago" or NA if player is still alive

- `nameFirst` : First name e.g. "John"

- `nameLast` : Surname e.g. "Smith"

- `nameGiven` : Full name e.g. "John Smith"

- `weight` : Weight in lbs e.g. 212

- `height` : Height in inches e.g. 72

- `bats` : Hand which players bats with. Either "R" or "L".

- `throws` : Hand which players throws with. Either "R" or "L". 

- `debut` : Date of first game e.g. 1982-12-25 in YYYY-MM-DD format

- `finalGame` : Date of final game e.g. 1982-12-25 in YYYY-MM-DD format

- `retroID` : Player's ID used in [Retrosheets](https://www.retrosheet.org/) datasets

- `bbrefID` : Player's ID used in [Baseball Reference](https://www.baseball-reference.com/) datasets

## player-fielding.csv

660 entries x 17 variables

Each entry contains the most commonly fielding stats for each player in a season.
Note that: the Nationals and Rays only joined the MLB namely in 2005 and 2008 so
data is missing until then. Also, the last 8 cols. only started being calculated in 2002.
Some players might appear twice in a sesason if they played in different positions.


More details about the vairables [here](https://blogs.fangraphs.com/glossary/)

- `team` : Team name.

- `season` : Season year.

- `name` : Name of the player.

- `pos` : Fielding position.

- `g`: Number of games.

- `gs`: Grand slams.

- `inn` : Number of innings.

- `po` :  Putouts.

- `a` : Assists.

- `drs` : Defensive runs saved.

- `arm` : Outfield arm runs.

- `dpr` : Double play runs.

- `rng_r` : Range runs.

- `err_r` : Error runs.

- `uzr` : Ultimate zone rating.

- `uzr_150` : Ultimate zone rating per 150 games.

- `def` : Defense, Fielding Runs Above Average + positional adjustment.

## player-batting.csv

28911 entries x 21 variables

Each entry contains the most commonly batting stats for each player in a season.

Some players might appear twice in a sesason if they played in different positions.


More details about the vairables [here](https://blogs.fangraphs.com/glossary/)

- `team` : Team name.

- `season` : Season year.

- `name` : Name of the player.

- `age` : Age of the player.

- `g` : Number of games in which the player has appeared.

- `pa` : Number of times the player has come to the plate.

- `hr` : Number of home runs.

- `sb` : Number of stolen bases.

- `bb` : Total number of walks (includes IBB).

- `k` : Frequency with which the batter has struck out.

- `iso` : Average number of extra bases per at bat.

- `babip` : The rate at which the batter gets a hit when he puts the ball in play.

- `avg` : Rate of hits per at bat.

- `obp` : Rate at which the batter reaches base.

- `slg` : Average number of total bases per at bat.

- `w_oba` : Combines all the different aspects of hitting into one metric, weighting each of them in proportion to their actual run value.

- `w_rc` : Number of runs a player has generated for his team as a result of his wOBA and playing time.

- `bsr` : Number of runs above or below average a player has been worth on the bases, based on stolen bases, caught stealing, extra bases taken, outs on the bases, and avoiding double plays.

- `off` : Number of runs above or below average a player has been worth offensively, combining Batting Runs and BsR.

- `def` : Number of runs above or below average a player has been worth on defense, combining Fielding Runs (Total Zone before 2002, UZR after) and the positional adjustment.

- `war` :  A comprehensive statistic that estimates the number of wins a player has been worth to his team compared to a freely available player such as a minor league free agent.(more detail about this variable [here](https://library.fangraphs.com/war/war-position-players/))

## teams-cleaned.csv

643 entries x 20 columns

Each entry contains the average stats of the team used in each season.
Note : The last 4 columns are not calculated until 2002. Also, the teams from row 113 to row 140 still not been calculating in 2002.

More details about the vairables [here](https://blogs.fangraphs.com/glossary/)

- `team` : Team name.

- `season` : Season year.

- `win_rate` : The win rate of the team.

- `mean_pa` : Average of the number of times the player has come to the plate in the team in the season.

- `mean_avg` : Average of the rate of hits per at bat of the team in the season.

- `mean_slg` : Average number of total bases per at bat of the team in the season.

- `mean_iso` : Average number of extra bases per at bat.

- `mean_babip` : Rate at which the batter gets a hit when he puts the ball in play.

- `mean_obp` : Rate at which the batter reaches base.

- `mean_w_oba`: Combines all the different aspects of hitting into one metric, weighting each of them in proportion to their actual run value.

- `mean_w_rc` : Number of runs a player has generated for his team as a result of his wOBA and playing time.

- `mean_bsr` : Number of runs above or below average a player has been worth on the bases, based on stolen bases, caught stealing, extra bases taken, outs on the bases, and avoiding double plays.

- `mean_off` : Number of runs above or below average a player has been worth offensively, combining Batting Runs and BsR.

- `mean_war` : A comprehensive statistic that estimates the number of wins a player has been worth to his team compared to a freely available player such as a minor league free agent.(more detail about this variable [here](https://library.fangraphs.com/war/war-position-players/))

- `mean_innings` : Average of innings.

- `mean_drs` : Defensive runs saved.

- `mean_uzr` : Ultimate zone rating.

- `mean_uzr150` : Ultimate zone rating per 150 games.

- `def` : Defense, Fielding Runs Above Average + positional adjustment.














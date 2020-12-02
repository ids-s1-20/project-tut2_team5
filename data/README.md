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

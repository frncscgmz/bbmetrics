bbmetrics
===

## Description
bbmetrics is a baseball data analysis tool with a Unixy flavor.

# Current avaliable stats
*   AVG(Batting average)
*   OBP(On-Base percentage)
*   SLG(Slugging percentage)
*   OPS(On-base plus slugging percentage)
*   BABIP(Batting average on balls in play)
*   ISO(Isolated power)
*   EqA(Equivalent average)
*   ERA(Earned Run average)
*   ERA+(Earned run average adjusted to player's ballpark(s))
*   WHIP(Walks plus hits per inning pitched)
*   FIP(Fielding-independent pitching)
*   Fielding Percentage
*   Range Factor
*   Pythagorean Expectation

## Usage

# Gem Usage
```ruby
require 'bbmetric'

bb = BBMetric.new(222,660)
```

# Command Line Usage
```
./bbmetric -ops 660 225 36 5 299 5 --p 4 --verbose --color
```

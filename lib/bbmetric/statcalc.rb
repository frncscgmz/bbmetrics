module BBmetric
   require 'ostruct'

   class StatCalc

      def initialize(options)
         @options = options
      end

      def calculate(data)
         if @options.avg
            # Batting average
            # hits / at-bats
            @options.hits.to_f / @options.atbats.to_f
         elsif @options.obp
            # On-Base percentage
            # (hits + walks + hit by pitch) / 
            # (at-bats + walks + hit by pitch + sacrifice flies)
            (@options.hits.to_f + @options.walks.to_f + @options.hbp.to_f) / \
               (@options.atbats.to_f + @options.walks.to_f + @options.hbp.to_f \
                + @options.sacfly.to_f)
         elsif @options.slg
            # Slugging percentage
            # hits + 2*doubles + 3*triples + 4*HR's / at-bats
            (@options.hits.to_f + 2*(@options.doubles.to_f) + \
             3*(@options.triples.to_f) + 4*(@options.hrs.to_f)) / \
             @options.atbats.to_f
         elsif @options.whip
            # Walks plus hits per inning pitched 
            # walks + hits / innings pitched
            (@options.walks.to_f + @options.hits.to_f) / @options.ip.to_f
         elsif @options.era
            # Earned run average
            # 9 * earned runs allowed / innings pitched
            9*(@options.runs.to_f / @options.ip.to_f)
         elsif @options.babip
            # Batting average on balls in play
            # hits - HR's / at-bats - strikeouts - HR's + sacrifice flies
            (@options.hits.to_f - @options.hrs.to_f) / \
               (@options.atbats.to_f - @options.ks.to_f - \
                @options.hrs.to_f + @options.sacfly.to_f)
         elsif @options.pye
            # Bill James Pythagorean expectation formula
            # runs allowed ^ 1.83 / runs scored ^ 1.83
            (@options.runsscored.to_f**1.83) / (@options.runsscored.to_f**1.83 + \
               @options.runsallowed.to_f**1.83)
         elsif @options.fp
            # Fielding percentage
            # putouts + assists / putouts
            (@options.putouts.to_f + @options.assists.to_f) / (@options.putouts.to_f + \
               @options.assists.to_f + @options.errors.to_f)
         elsif @options.rf
            # Range factor
            # assists + putouts / games
            (@options.assists.to_f + @options.putouts.to_f) / @options.games.to_f
         end
      end
   end
end

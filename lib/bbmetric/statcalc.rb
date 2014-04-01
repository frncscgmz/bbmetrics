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
            data[0].to_f / data[1].to_f
         elsif @options.obp
            # On-Base percentage
            # (hits + walks + hit by pitch) / 
            # (at-bats + walks + hit by pitch + sacrifice flies)
            (data[0].to_f + data[1].to_f + data[2].to_f) / (data[3].to_f + \
                  data[1].to_f + data[2].to_f + + data[4].to_f)
         elsif @options.slg
            # Slugging percentage
            # hits + 2*doubles + 3*triples + 4*HR's / at-bats
            (data[0].to_f + 2*(data[1].to_f) + 3*(data[2].to_f) + 4*(data[3].to_f))/ data[4].to_f
         elsif @options.whip
            # Walks plus hits per inning pitched 
            # walks + hits / innings pitched
            (data[0].to_f + data[1].to_f) / data[2].to_f
         elsif @options.era
            # Earned run average
            # 9 * earned runs allowed / innings pitched
            9*(data[0].to_f / data[1].to_f)
         elsif @options.babip
            # Batting average on balls in play
            # hits - HR's / at-bats - strikeouts - HR's + sacrifice flies
            (data[0].to_f - data[1].to_f) / (data[2].to_f - data[3].to_f - data[1].to_f + data[4].to_f)
         end
      end
   end
end

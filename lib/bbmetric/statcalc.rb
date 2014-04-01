module BBmetric
   require 'ostruct'

   class StatCalc

      def initialize(options)
         @options = options
      end

      def calculate(data)
         if @options.ba
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
            (data[0].to_f + data[1].to_f) / data[2].to_f
         end
      end
   end
end

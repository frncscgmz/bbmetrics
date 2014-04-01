module BBmetric
   require 'ostruct'

   class StatCalc

      def initialize(options)
         @options = options
      end

      def calculate(data)
         # Batting average
         if @options.ba
            puts data[0].to_f / data[1].to_f
         end
      end
   end
end

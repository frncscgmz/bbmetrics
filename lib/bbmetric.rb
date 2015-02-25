require "thor"
require "colorize"

require_relative "bbmetric/cli"
require_relative "bbmetric/statcalc"

class BBMetric

   attr_accessor :precision

   def initialize(precision = 3)
      @precision = precision
   end

   def battingaverage(hits,atbats)
      (BBmetric::StatCalc.battingaverage(hits,atbats))
         .round(precision) if precision
   end
end

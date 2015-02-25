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

   def onbasepercentage(hits, walks, hbp, atbats, sacfly)
      (BBmetric::StatCalc.onbasepercentage(hits,walks,hbp,atbats,sacfly))
         .round(precision) if precision
   end

   def slugging(hits, doubles, triples, hrs, atbats)
      (BBmetric::StatCalc.slugging(hits,doubles,triples,hrs,atbats))
         .round(precision) if precision
   end

   def onbasepercentageslugging(atbats, hits, walks, hbp, bases, sacfly)
      (BBmetric::StatCalc.onbasepercentageslugging(atbats,hits,walks,hbp,bases,sacfly))
         .round(precision) if precision
   end

   def babip(hits, walks, hrs, atbats, ks, sacfly)
      (BBmetric::StatCalc.babip(hits,walks,hrs,atbats,ks,sacfly))
         .round(precision) if precision
   end

   def isolatedpower(doubles, triples, hrs, atbats)
      (BBmetric::StatCalc.isolatedpower(doubles,triples,hrs,atbats))
         .round(precision) if precision
   end

   def equivalentaverage(hits, totalbases, walks, hbp, sb, sachits, sacfly, atbats, cs)
      (BBmetric::StatCalc.equivalentaverage(hits,totalbases,walks,hbp,sb,sachits,
         sacfly,atbats,cs)).round(precision) if precision
   end

   def earnedrunaverage(runs, ip)
      (BBmetric::StatCalc.earnedrunaverage(runs, ip))
         .round(precision) if precision
   end

   def earnedrunaverageplus(runs, ip, lgera)
      (BBmetric::StatCalc.earnedrunaverageplus(runs,ip,lgera))
         .round(precision) if precision
   end

   def walksplushits(walks, hits, ip)
      (BBmetric::StatCalc.walksplushits(walks,hits,ip))
         .round(precision) if precision
   end

   def fieldingpercentage(putouts, assists ,errors)
      (BBmetric::StatCalc.fieldingpercentage(putouts,assists,errors))
         .round(precision) if precision
   end

   def rangefactor(putouts, assists ,games)
      (BBmetric::StatCalc.rangefactor(putouts,assists,games))
         .round(precision) if precision
   end

   def pythagoreanexpectationformula(runsscored, runsallowed)
      (BBmetric::StatCalc.pythagoreanexpectationformula(runsscored,runsallowed))
         .round(precision) if precision
   end
end

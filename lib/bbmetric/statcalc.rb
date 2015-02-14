module BBmetric
   class StatCalc

      def self.battingaverage(hits,atbats)
         hits.to_f / atbats.to_f
      end

      def self.onbasepercentage(hits, walks, hbp, atbats, sacfly)
         (hits.to_f + walks.to_f + hbp.to_f) / \
            (atbats.to_f + walks.to_f + hbp.to_f + sacfly.to_f)
      end

      def self.slugging(hits, doubles, triples, hrs, atbats)
         (hits.to_f + 2*(doubles.to_f) + 3*(triples.to_f) + 4*(hrs.to_f)) / \
            atbats.to_f
      end

      def self.onbasepercentageslugging(atbats, hits, walks, hbp, bases, sacfly)
         (atbats.to_f * (hits.to_f + walks.to_f + hbp.to_f)+bases.to_f*\
            (atbats.to_f + walks.to_f + sacfly.to_f + hbp.to_f))/\
            (atbats.to_f * (atbats.to_f + walks.to_f + sacfly.to_f + hbp.to_f))
      end

      def self.babip(hits, walks, hrs, atbats, ks, sacfly)
         (hits.to_f - hrs.to_f) / (atbats.to_f - ks.to_f - hrs.to_f + sacfly.to_f)
      end

      def self.iso(doubles, triples, hrs, atbats)
         ((doubles.to_f) + (2*triples.to_f) + (3*hrs.to_f)) / (atbats.to_f)
      end

      def self.eqa(hits,totalbases,walks,hbp,sb,sachits,sacfly,atbats,cs)
         (hits.to_f + totalbases.to_f + 1.5 * (walks.to_f + hbp.to_f + sb.to_f) + \
          sachits.to_f + sacfly.to_f) / (atbats.to_f + walks.to_f + \
                           hbp.to_f + sachits.to_f + sacfly.to_f + cs.to_f + (sb.to_f/3))
      end

      def self.earnedrunaverage(runs, ip)
         9*(runs.to_f / ip.to_f)
      end

      def self.earnedrunaverageplus(runs, ip, lgera)
         100*(lgera.to_f/(9*(runs.to_f / ip.to_f)))
      end

      def self.walksplushits(walks, hits, ip)
         (walks.to_f + hits.to_f) / ip.to_f
      end

      def self.fieldingpercentage(putouts, assists ,errors)
         (putouts.to_f + assists.to_f) / (putouts.to_f + \
            assists.to_f + errors.to_f)
      end

      def self.rangefactor(putouts, assists ,games)
         (assists.to_f + putouts.to_f) / games.to_f
      end

      def self.pythagoreanexpectationformula(runsscored, runsallowed)
         (runsscored.to_f**1.83) / (runsscored.to_f**1.83 + \
            runsallowed.to_f**1.83)
      end
   end
end

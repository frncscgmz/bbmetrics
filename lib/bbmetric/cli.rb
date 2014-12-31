module BBmetric
   class Cli < Thor
      # Class-wide options
      class_option :verbose, :type => :boolean
      class_option :pretty,  :type => :boolean

      # Main function aliases
      map "-ba"      => :battingaverage
      map "-obp"     => :onbasepercentage
      map "-slg"     => :slugging
      map "-babip"   => :babip
      map "-era"     => :earnedrunaverage
      map "-whip"    => :walksplushits
      map "-fp"      => :fieldingpercentage
      map "-rf"      => :rangefactor
      map "-pye"     => :pythagoreanexpectationformula

      map "-v"       => :version
      
      #
      # Offensive options
      #
      # Batting average
      # hits / at-bats
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "battingaverage <hits> <at-bats>",
         "Batting Average hits / at-bats"
      def battingaverage(hits,atbats)
         puts (hits.to_f / atbats.to_f).round(options[:precision]) if options[:precision]
      end

      # On-Base percentage
      # (hits + walks + hit by pitch) / 
      # (at-bats + walks + hit by pitch + sacrifice flies)
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "onbasepercentage <hits> <walks> <hbp> <atbats> <sacfly>",
         "On-Base percentage"
      def onbasepercentage(hits, walks, hbp, atbats, sacfly)
         puts ((hits.to_f + walks.to_f + hbp.to_f) / \
               (atbats.to_f + walks.to_f + hbp.to_f + sacfly.to_f))
                  .round(options[:precision]) if options[:precision]
      end

      # Slugging percentage
      # hits + 2*doubles + 3*triples + 4*HR's / at-bats
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "slugging <hits> <doubles> <triples> <hrs> <atbats>",
         "Slugging Percentage"
      def slugging(hits, doubles, triples, hrs, atbats)
         puts ((hits.to_f + 2*(doubles.to_f) + \
            3*(triples.to_f) + 4*(hrs.to_f)) / \
            atbats.to_f).round(options[:precision]) if options[:precision]
      end

      # Batting average on balls in play
      # hits - HR's / at-bats - strikeouts - HR's + sacrifice flies
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "babip <hits> <walks> <hrs> <atbats> <ks> <sacfly>",
         "Batting average on balls in play"
      def babip(hits, walks, hrs, atbats, ks, sacfly)
         puts ((hits.to_f - hrs.to_f) / (atbats.to_f - ks.to_f - \
            hrs.to_f + sacfly.to_f))
            .round(options[:precision]) if options[:precision]
      end

      #
      # Pitching options
      #
      # Earned run average
      # 9 * earned runs allowed / innings pitched
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "earnedrunaverage <runs> <ip>",
         "Earned run average"
      def earnedrunaverage(runs, ip)
         puts (9*(runs.to_f / ip.to_f))
            .round(options[:precision]) if options[:precision]
      end

      # Walks plus hits per inning pitched 
      # walks + hits / innings pitched
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "walksplushits <walks> <hits> <ip>",
         "Walks and hits per inning pitched"
      def walksplushits(walks, hits, ip)
         puts ((walks.to_f + hits.to_f) / ip.to_f)
            .round(options[:precision]) if options[:precision]
      end

      #def fieldingindependentpitching(hrs,walks,ks,ip)
      #end

      #def defenseindependentcomponentera(hrs,walks,hbp,ks,ip)
      #end

      #
      # Fielding options
      #
      # Fielding percentage
      # putouts + assists / putouts
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "fieldingpercentage <putouts> <assists> <errors>",
         "Fielding percentage"
      def fieldingpercentage(putouts, assists ,errors)
         puts ((putouts.to_f + assists.to_f) / (putouts.to_f + \
            assists.to_f + errors.to_f))
            .round(options[:precision]) if options[:precision]
      end

      # Range factor
      # assists + putouts / games
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "rangefactor <assists> <putouts> <games>",
         "Range factor"
      def rangefactor(putouts, assists ,games)
            puts ((assists.to_f + putouts.to_f) / games.to_f)
               .round(options[:precision]) if options[:precision]
      end

      #
      # Team options
      #
      # Bill James Pythagorean expectation formula
      # runs allowed ^ 1.83 / runs scored ^ 1.83
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "pythagoreanexpectationformula <runsscored> <runsallowed>",
         "Bill James Pythagorean expectation formula"
      def pythagoreanexpectationformula(runsscored, runsallowed)
         puts ((runsscored.to_f**1.83) / (runsscored.to_f**1.83 + \
            runsallowed.to_f**1.83))
            .round(options[:precision]) if options[:precision]
      end

      #
      # Misc options
      #
      desc "-v","Print version number."
      def version
         require "rubygems"
         spec = Gem::Specification::load("../bbmetric.gemspec")
         puts "bbmetric #{spec.version}\n"
      end

   end
end

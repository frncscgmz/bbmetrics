module BBmetric
   class Cli < Thor
      # Class-wide options
      class_option :verbose, :type => :boolean
      class_option :pretty,  :type => :boolean

      # Main function aliases
      map "-ba"      => :battingaverage
      map "-obp"     => :onbasepercentage
      map "-ops"     => :onbasepercentageslugging
      map "-slg"     => :slugging
      map "-babip"   => :babip
      map "-era"     => :earnedrunaverage
      map "-eraplus" => :earnedrunaverageplus
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
      desc "battingaverage -ba <hits> <at-bats>",
         "Batting Average hits / at-bats"
      def battingaverage(hits,atbats)
         puts "Calculating batting average" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "Hits: #{hits} At-Bats: #{atbats}" if options[:verbose]
         puts "#{hits} / #{atbats}" if options[:verbose]
         puts (hits.to_f / atbats.to_f).round(options[:precision]) \
            if options[:precision]
      end

      # On-Base percentage
      # (hits + walks + hit by pitch) / 
      # (at-bats + walks + hit by pitch + sacrifice flies)
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "onbasepercentage -obp <hits> <walks> <hbp> <atbats> <sacfly>",
         "On-Base percentage"
      def onbasepercentage(hits, walks, hbp, atbats, sacfly)
         puts "Calculating On-Base percentage" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "Hits: #{hits} Walks: #{walks} Hit By Pitches: #{hbp} At-Bats: #{\
            atbats} Sacrifice Flies: #{sacfly}" if options[:verbose]
         puts "(#{hits} + #{walks} + #{hbp}) / (#{atbats} + #{\
            walks} + #{hbp} + #{sacfly})" if options[:verbose]
         puts ((hits.to_f + walks.to_f + hbp.to_f) / \
               (atbats.to_f + walks.to_f + hbp.to_f + sacfly.to_f))
                  .round(options[:precision]) if options[:precision]
      end

      # Slugging percentage
      # hits + 2*doubles + 3*triples + 4*HR's / at-bats
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "slugging -slg <hits> <doubles> <triples> <hrs> <atbats>",
         "Slugging percentage"
      def slugging(hits, doubles, triples, hrs, atbats)
         puts "Calculating Slugging percentage" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "#{hits} + 2*(#{doubles}) + 3*(#{triples}) + 4*(#{hrs}) / #{atbats}" \
            if options[:verbose]
         puts ((hits.to_f + 2*(doubles.to_f) + \
            3*(triples.to_f) + 4*(hrs.to_f)) / \
            atbats.to_f).round(options[:precision]) if options[:precision]
      end

      # On-Base percentage plus slugging
      # (atbats * (hits + walks + hbp) + bases * (atbats + walks + sacfly + 
      # hbp)) / (atbats * (atbats + walks + sacfly + hbp))
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "onbasepercentageslugging -slg <hits> <doubles> <triples> <hrs> <atbats>",
         "On-Base percentage plus Slugging"
      def onbasepercentageslugging(atbats, hits, walks, hbp, bases, sacfly)
         puts "Calculating On-Base percentage plus Slugging" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "(#{atbats} * (#{hits} + #{walks} + #{hbp}) + #{\
            bases} * (#{atbats} + #{walks} + #{sacfly} + #{\
            hbp})) / (#{atbats} * (#{atbats} + #{walks} + #{sacfly} + #{hbp}))"\
            if options[:verbose]
         puts ((atbats.to_f * (hits.to_f + walks.to_f + hbp.to_f)+bases.to_f*\
            (atbats.to_f + walks.to_f + sacfly.to_f + hbp.to_f))/ \
            (atbats.to_f * (atbats.to_f + walks.to_f + sacfly.to_f + hbp.to_f)))\
            .round(options[:precision]) if options[:precision]
      end

      # Batting average on balls in play
      # hits - HR's / at-bats - strikeouts - HR's + sacrifice flies
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "babip -babip <hits> <walks> <hrs> <atbats> <ks> <sacfly>",
         "Batting average on balls in play"
      def babip(hits, walks, hrs, atbats, ks, sacfly)
         puts "Calculating BABIP" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "(#{hits} - #{hrs}) / (#{atbats} - #{ks} - #{hrs} + #{sacfly})" \
            if options[:verbose]
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
      desc "earnedrunaverage -era <runs> <ip>",
         "Earned run average"
      def earnedrunaverage(runs, ip)
         puts "Calculating ERA" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "9*(#{runs} / #{ip})" if options[:verbose]
         puts (9*(runs.to_f / ip.to_f))
            .round(options[:precision]) if options[:precision]
      end

      # Earned run average adjusted to player's ballpark(s)
      # 9 * earned runs allowed / innings pitched
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "earnedrunaverageplus -eraplus <runs> <ip> <lgera>",
         "Earned run average adjusted to player's ballpark(s)"
      def earnedrunaverageplus(runs, ip, lgera)
         puts "Calculating ERA+" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "100 * (#{lgera}/(9 * (#{runs} / #{ip})))" \
            if options[:verbose]
         puts (100*(lgera.to_f/(9*(runs.to_f / ip.to_f))))  
            .round(options[:precision]) if options[:precision]
      end

      # Walks plus hits per inning pitched 
      # walks + hits / innings pitched
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "walksplushits -whip <walks> <hits> <ip>",
         "Walks and hits per inning pitched"
      def walksplushits(walks, hits, ip)
         puts "Calculating WHIP" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "(#{walks} + #{hits}) / #{ip}" if options[:verbose]
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
      desc "fieldingpercentage -fp <putouts> <assists> <errors>",
         "Fielding percentage"
      def fieldingpercentage(putouts, assists ,errors)
         puts "Calculating Fielding percentage" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "(#{putouts} + #{assists}) / (#{putouts} + #{\
            assists} + #{errors})" if options[:verbose]
         puts ((putouts.to_f + assists.to_f) / (putouts.to_f + \
            assists.to_f + errors.to_f))
            .round(options[:precision]) if options[:precision]
      end

      # Range factor
      # assists + putouts / games
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "rangefactor -rf <assists> <putouts> <games>",
         "Range factor"
      def rangefactor(putouts, assists ,games)
         puts "Calculating Range factor" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "(#{assists} + #{putouts}) / #{games}" if options[:verbose]
         puts ((assists.to_f + putouts.to_f) / games.to_f)
            .round(options[:precision]) if options[:precision]
      end

      #
      # Team options
      #
      # Bill James Pythagorean expectation formula
      # runs allowed ^ 1.83 / runs scored ^ 1.83
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "pythagoreanexpectationformula -pye <runsscored> <runsallowed>",
         "Bill James Pythagorean expectation formula"
      def pythagoreanexpectationformula(runsscored, runsallowed)
         puts "Calculating Bill James Pythagorean expectation" if options[:verbose]
         puts "Precision: #{options[:precision]}" \
            if options[:verbose] and options[:precision]
         puts "(#{runsscored}^1.83) / (#{runsscored}^1.83 + #{\
            runsallowed}^1.83)" if options[:verbose]
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

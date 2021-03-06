module BBmetric
   class Cli < Thor
      # Class-wide options
      class_option :verbose, :type => :boolean
      class_option :color,   :type => :boolean

      # Main function aliases
      map "-ba"      => :battingaverage
      map "-obp"     => :onbasepercentage
      map "-ops"     => :onbasepercentageslugging
      map "-slg"     => :slugging
      map "-babip"   => :babip
      map "-iso"     => :isolatedpower
      map "-eqa"     => :equivalentaverage
      map "-era"     => :earnedrunaverage
      map "-eraplus" => :earnedrunaverageplus
      map "-whip"    => :walksplushits
      map "-fip"     => :fieldingindependentpitching
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
         puts "Calculating #{colorize_string("batting average",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]
         puts "Hits: #{colorize_string("#{hits}",:green)} At-Bats: #{\
            colorize_string("#{atbats}",:red)}" if options[:verbose]

         puts "#{colorize_string("#{hits}",:green)} / #{colorize_string(\
            "#{atbats}",:red)}" if options[:verbose]
         puts (BBmetric::StatCalc.battingaverage(hits,atbats))\
            .round(options[:precision]) if options[:precision]
      end

      # On-Base percentage
      # (hits + walks + hit by pitch) / 
      # (at-bats + walks + hit by pitch + sacrifice flies)
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "onbasepercentage -obp <hits> <walks> <hbp> <atbats> <sacfly>",
         "On-Base percentage"
      def onbasepercentage(hits, walks, hbp, atbats, sacfly)
         puts "Calculating #{colorize_string("On-Base percentage",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]
         puts "Hits: #{colorize_string("#{hits}",:green)} Walks: #{
            colorize_string("#{walks}",:red)} Hit By Pitches: #{
            colorize_string("#{hbp}",:magenta)} At-Bats: #{
            colorize_string("#{atbats}",:cyan)} Sacrifice Flies: #{
            colorize_string("#{sacfly}",:light_yellow)}" if options[:verbose]

         puts "(#{colorize_string("#{hits}",:green)} + #{colorize_string("#{
            walks}",:red)} + #{colorize_string("#{hbp}",:magenta)}) / (#{
            colorize_string("#{atbats}",:cyan)} + #{colorize_string("#{
            walks}",:red)} + #{colorize_string("#{hbp}",:magenta)} + #{
            colorize_string("#{sacfly}",:light_yellow)})" if options[:verbose]
         puts (BBmetric::StatCalc.onbasepercentage(hits,walks,hbp,atbats,sacfly))\
            .round(options[:precision]) if options[:precision]
      end

      # Slugging percentage
      # hits + 2*doubles + 3*triples + 4*HR's / at-bats
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "slugging -slg <hits> <doubles> <triples> <hrs> <atbats>",
         "Slugging percentage"
      def slugging(hits, doubles, triples, hrs, atbats)
         puts "Calculating #{colorize_string("Slugging percentage",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]
         puts "Hits: #{colorize_string("#{hits}",:green)} Doubles: #{
            colorize_string("#{doubles}",:red)} Triples: #{
            colorize_string("#{triples}",:magenta)} At-Bats: #{
            colorize_string("#{atbats}",:cyan)} Home-Runs: #{
            colorize_string("#{hrs}",:light_yellow)}" if options[:verbose]

         puts "#{colorize_string("#{hits}",:green)} + 2*(#{colorize_string("#{\
            doubles}",:red)}) + 3*(#{colorize_string("#{triples}",:magenta)\
            }) + 4*(#{colorize_string("#{hrs}",:light_yellow)}) / #{\
            colorize_string("#{atbats}",:cyan)}" \
            if options[:verbose]
         puts (BBmetric::StatCalc.slugging(hits,doubles,triples,hrs,atbats))\
            .round(options[:precision]) if options[:precision]
      end

      # On-Base percentage plus slugging
      # (atbats * (hits + walks + hbp) + bases * (atbats + walks + sacfly + 
      # hbp)) / (atbats * (atbats + walks + sacfly + hbp))
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "onbasepercentageslugging -slg <atbats> <hits> <walks> <hbp> <bases> <sacfly>",
         "On-Base percentage plus Slugging"
      def onbasepercentageslugging(atbats, hits, walks, hbp, bases, sacfly)
         puts "Calculating #{colorize_string("On-Base percentage plus Slugging",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

         puts "At-Bats: #{colorize_string("#{atbats}",:green)} Hits: #{
            colorize_string("#{hits}",:red)} Walks: #{
            colorize_string("#{walks}",:magenta)} Hit By Pitches: #{
            colorize_string("#{hbp}",:cyan)} Bases: #{
            colorize_string("#{bases}",:light_yellow)} Sacrifice Flys: #{
            colorize_string("#{sacfly}",:light_green)}" if options[:verbose]

         puts "(#{colorize_string("#{atbats}",:green)} * (#{colorize_string("#{
            hits}",:red)} + #{colorize_string("#{walks}",:magenta)} + #{
            colorize_string("#{hbp}",:cyan)} + #{colorize_string("#{
            bases}",:light_yellow)} * (#{colorize_string("#{atbats}",:green)} + #{
            colorize_string("#{walks}",:magenta)} + #{colorize_string("#{
            sacfly}",:light_green)} + #{colorize_string("#{hbp}",:cyan)})) / (#{
            colorize_string("#{atbats}",:green)} * (#{colorize_string("#{
            atbats}",:green)} + #{colorize_string("#{walks}",:magenta)} + #{
            colorize_string("#{sacfly}",:light_green)} + #{colorize_string("#{
            hbp}",:cyan)}))"\
            if options[:verbose]

         puts (BBmetric::StatCalc.onbasepercentageslugging(\
            atbats,hits,walks,hbp,bases,sacfly))\
            .round(options[:precision]) if options[:precision]
      end

      # Batting average on balls in play
      # hits - HR's / at-bats - strikeouts - HR's + sacrifice flies
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "babip -babip <hits> <walks> <hrs> <atbats> <ks> <sacfly>",
         "Batting average on balls in play"
      def babip(hits, walks, hrs, atbats, ks, sacfly)
         puts "Calculating #{colorize_string("BABIP",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

         puts "Hits: #{colorize_string("#{hits}",:green)} Walks: #{
            colorize_string("#{walks}",:red)} Home-Runs: #{
            colorize_string("#{hrs}",:magenta)} At-Bats: #{
            colorize_string("#{atbats}",:cyan)} Strike-Outs: #{
            colorize_string("#{ks}",:light_yellow)} Sacrifice Flys: #{
            colorize_string("#{sacfly}",:light_green)}" if options[:verbose]

         puts "(#{colorize_string("#{hits}",:green)} - #{colorize_string("#{hrs}"\
            ,:magenta)}) / (#{colorize_string("#{atbats}",:cyan)} - #{
            colorize_string("#{ks}",:light_yellow)} - #{colorize_string(\
            "#{hrs}",:magenta)} + #{colorize_string("#{sacfly}",:light_green)})" \
            if options[:verbose]
         puts (BBmetric::StatCalc.babip(hits,walks,hrs,atbats,ks,sacfly))
            .round(options[:precision]) if options[:precision]
      end

      # Isolated Power
      # ((doubles) + (2*triples) + (3*HR's)) / atbats
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "isolatedpower -iso <doubles> <triples> <hrs> <atbats>",
         "Isolated Power"
      def isolatedpower(doubles, triples, hrs, atbats)
         puts "Calculating #{colorize_string("ISO",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

         puts "Doubles: #{colorize_string("#{doubles}",:green)} Triples:: #{
            colorize_string("#{triples}",:red)} Home-Runs: #{
            colorize_string("#{hrs}",:magenta)} At-Bats: #{
            colorize_string("#{atbats}",:cyan)}" if options[:verbose]

         puts "(#{colorize_string("#{doubles}",:green)}) + (2*#{colorize_string(\
            "#{triples}",:red)}) + (3*#{colorize_string("#{hrs}",:magenta)}) / (#{\
            colorize_string("#{atbats}",:cyan)})" if options[:verbose]
         puts (BBmetric::StatCalc.iso(doubles, triples, hrs, atbats))
            .round(options[:precision]) if options[:precision]
      end

      # Equivalent average
      # ((hits) + (totalbases) + 1.5 * (walks + hbp) + sb + sachits + sacfly) / 
      # (atbats + walks + hbp + sachits + sacfly + cs + (sb/3))
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "equivalentaverage -eqa <hits> <totalbases> <walks> <hbp> <sb> \
         <sachits> <sacfly> <atbats> <cs>",
         "Equivalent average"
      def equivalentaverage(hits, totalbases, walks, hbp, sb, sachits, sacfly, atbats, cs)
         puts "Calculating #{colorize_string("EqA",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

        puts "Hits: #{colorize_string("#{hits}",:green)} "\
            "Total Bases: #{colorize_string("#{totalbases}",:red)} "\
            "Walks: #{colorize_string("#{walks}",:magenta)} "\
            "Hit By Pitch: #{colorize_string("#{hbp}",:light_red)} "\
            "Sacrifice Bunts: #{colorize_string("#{sb}",:cyan)} "\
            "Sacrifice Hits: #{colorize_string("#{sachits}",:light_black)} "\
            "Sacrifice Flys: #{colorize_string("#{sacfly}",:light_yellow)} "\
            "At-Bats: #{colorize_string("#{atbats}",:light_green)}"\
            if options[:verbose]

         puts "(#{colorize_string("#{hits}",:green)} + "\
            "#{colorize_string("#{totalbases}",:red)} + 1.5 * "\
            "(#{colorize_string("#{walks}",:magenta)} + "\
            "#{colorize_string("#{hbp}",:light_red)} + "\
            "#{colorize_string("#{sb}",:cyan)}) + "\
            "#{colorize_string("#{sachits}",:light_black)} + "\
            "#{colorize_string("#{sacfly}",:light_yellow)}) / "\
            "(#{colorize_string("#{atbats}",:light_green)} + "\
            "#{colorize_string("#{walks}",:magenta)} + "\
            "#{colorize_string("#{hbp}",:light_red)} + "\
            "#{colorize_string("#{sachits}",:light_black)} + "\
            "#{colorize_string("#{sacfly}",:light_yellow)} + "\
            "#{cs} + (#{colorize_string("#{sb}",:cyan)}/3))" \
            if options[:verbose]
         puts (BBmetric::StatCalc.eqa(hits,totalbases,walks,hbp,sb,sachits,sacfly,atbats,cs))
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
         puts "Calculating #{colorize_string("ERA",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

        puts "Runs: #{colorize_string("#{runs}",:green)} Innings Pitched: #{
            colorize_string("#{ip}",:red)}"

         puts "9*(#{colorize_string("#{runs}",:green)} / #{colorize_string("#{
            ip}",:red)})" if options[:verbose]
         puts (BBmetric::StatCalc.earnedrunaverage(runs,ip))
            .round(options[:precision]) if options[:precision]
      end

      # Earned run average adjusted to player's ballpark(s)
      # 9 * earned runs allowed / innings pitched
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "earnedrunaverageplus -eraplus <runs> <ip> <lgera>",
         "Earned run average adjusted to player's ballpark(s)"
      def earnedrunaverageplus(runs, ip, lgera)
         puts "Calculating #{colorize_string("ERA+",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

         puts "Runs: #{colorize_string("#{runs}",:green)} "\
            "Innings Pitched: #{colorize_string("#{ip}",:red)} "\
            "League Average ERA: #{colorize_string("#{lgera}",:magenta)}"\
            if options[:verbose] 

         puts "100 * (#{colorize_string("#{lgera}",:magenta)}/("\
            "9 * (#{colorize_string("#{runs}",:green)} / "\
            "#{colorize_string("#{ip}",:red)})))"\
            if options[:verbose]
         puts (BBmetric::StatCalc.earnedrunaverageplus(runs,ip,lgera))  
            .round(options[:precision]) if options[:precision]
      end

      # Walks plus hits per inning pitched 
      # walks + hits / innings pitched
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "walksplushits -whip <walks> <hits> <ip>",
         "Walks and hits per inning pitched"
      def walksplushits(walks, hits, ip)
         puts "Calculating #{colorize_string("WHIP",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

         puts "Walks: #{colorize_string("#{walks}",:green)} "\
            "Hits: #{colorize_string("#{hits}",:red)} "\
            "Innings Pitched: #{colorize_string("#{ip}",:magenta)}"\
            if options[:verbose] 
         
         puts "(#{colorize_string("#{walks}",:green)} + "\
            "#{colorize_string("#{hits}",:red)}) / "\
            "#{colorize_string("#{ip}",:magenta)}" \
            if options[:verbose]
         puts (BBmetric::StatCalc.walksplushits(walks,hits,ip))
            .round(options[:precision]) if options[:precision]
      end

      # Fielding-independent pitching
      # (13 * HR + 3 * (Walks +HBP) - 2 * K)/IP + FIP constant
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "fieldingindependentpitching -fip <hrs> <walks> <hbp> <ks> <ip> <cfip>",
         "Fielding independent pitching"
      def fieldingindependentpitching(hrs,walks,hbp,ks,ip,cfip)
         puts "Calculating #{colorize_string("FIP",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

        puts "Home-Runs: #{colorize_string("#{hrs}",:green)} Walks: "\
            "#{colorize_string("#{walks}",:red)} Hit By Pitch: "\
            "#{colorize_string("#{hbp}",:magenta)} Strikeouts: "\
            "#{colorize_string("#{ks}",:cyan)} Innings pitched: "\
            "#{colorize_string("#{ip}",:light_red)} FIP Constat: "\
            "#{colorize_string("#{cfip}",:light_black)}" if options[:verbose] 

         puts "((13*#{colorize_string("#{hrs}",:green)}+3*"\
            "(#{colorize_string("#{walks}",:red)}+"\
            "#{colorize_string("#{hbp}",:magenta)}))-2*"\
            "#{colorize_string("#{ks}",:cyan)})/"\
            "#{colorize_string("#{ip}",:light_red)} + "\
            "#{colorize_string("#{cfip}",:light_black)}"\
            if options[:verbose] 

         puts (BBmetric::StatCalc.fieldingindependentpitching(
            hrs,walks,hbp,ks,ip,cfip)).round(options[:precision]) \
            if options[:precision]
      end

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
         puts "Calculating #{colorize_string("Fielding percentage",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

        puts "Put-Outs: #{colorize_string("#{putouts}",:green)} "\
            "Assists: #{colorize_string("#{assists}",:red)} "\
            "Errors: #{colorize_string("#{errors}",:magenta)}"

         puts "(#{colorize_string("#{putouts}",:green)} + "\
            "#{colorize_string("#{assists}",:red)} / "\
            "(#{colorize_string("#{putouts}",:green)} + "\
            "#{colorize_string("#{assists}",:red)} + "\
            "#{colorize_string("#{errors}",:magenta)})" \
            if options[:verbose]
         puts (BBmetric::StatCalc.fieldingpercentage(putouts,assists,errors))
            .round(options[:precision]) if options[:precision]
      end

      # Range factor
      # assists + putouts / games
      option :precision, :type => :numeric, :default => 3, :aliases => '--p'
      desc "rangefactor -rf <assists> <putouts> <games>",
         "Range factor"
      def rangefactor(putouts, assists ,games)
         puts "Calculating #{colorize_string("Range factor",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

        puts "Put-Outs: #{colorize_string("#{putouts}",:green)} "\
            "Assists: #{colorize_string("#{assists}",:red)} "\
            "Games: #{colorize_string("#{games}",:magenta)}"

         puts "(#{colorize_string("#{assists}",:red)} + "\
            "#{colorize_string("#{putouts}",:green)}) / "\
            "#{colorize_string("#{games}",:magenta)}"\
            if options[:verbose]
         puts (BBmetric::StatCalc.rangefactor(putouts,assists,games))
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
         puts "Calculating #{colorize_string(
            "Bill James Pythagorean expectation",:blue)}" \
            if options[:verbose]
         puts "Precision: #{colorize_string("#{options[:precision]}",:yellow)}" \
            if options[:verbose] and options[:precision]

         puts "Runs scored: #{colorize_string("#{runsscored}",:green)} "\
            "Runs allowed: #{colorize_string("#{runsallowed}",:red)})"

         puts "(#{colorize_string("#{runsscored}",:green)}^1.83) / "\
            "(#{colorize_string("#{runsscored}",:green)}^1.83 + "\
            "#{colorize_string("#{runsallowed}",:red)}^1.83)" \
            if options[:verbose]
         puts (BBmetric::StatCalc.pythagoreanexpectationformula(\
            runsscored, runsallowed))
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

      # Method for printing with color
      no_tasks do
         def colorize_string(message,color)
            options[:color] ? "#{message}".colorize(color) : "#{message}"
         end
      end

   end
end

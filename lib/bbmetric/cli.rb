module BBmetric
   class Cli < Thor
      map "-ba"      => :battingaverage
      map "-obp"     => :onbasepercentage
      map "-slg"     => :slugging
      map "-babip"   => :babip
      map "-era"     => :earnedrunaverage
      map "-whip"    => :walksplushits
      map "-fp"      => :fieldingpercentage
      map "-rf"      => :rangefactor
      map "-pye"     => :pythagoreanexpectationformula
      
      #
      # Offensive options
      #
      # Batting average
      # hits / at-bats
      desc "battingaverage <hits> <at-bats>", "Batting Average hits / at-bats"
      def battingaverage(hits,atbats)
         puts hits.to_f / atbats.to_f
      end

      # On-Base percentage
      # (hits + walks + hit by pitch) / 
      # (at-bats + walks + hit by pitch + sacrifice flies)
      desc "onbasepercentage <hits> <walks> <hbp> <atbats> <sacfly>",
         "On-Base percentage"
      def onbasepercentage(hits, walks, hbp, atbats, sacfly)
         puts (hits.to_f + walks.to_f + hbp.to_f) / \
            (atbats.to_f + walks.to_f + hbp.to_f + sacfly.to_f)
      end

      # Slugging percentage
      # hits + 2*doubles + 3*triples + 4*HR's / at-bats
      desc "slugging <hits> <doubles> <triples> <hrs> <atbats>",
         "Slugging Percentage"
      def slugging(hits, doubles, triples, hrs, atbats)
         puts (hits.to_f + 2*(doubles.to_f) + \
            3*(triples.to_f) + 4*(hrs.to_f)) / \
            atbats.to_f
      end

      # Batting average on balls in play
      # hits - HR's / at-bats - strikeouts - HR's + sacrifice flies
      desc "babip <walks> <hrs> <atbats> <ks> <sacfly>",
         "Batting average on balls in play"
      def babip(walks, hrs, atbats, ks, sacfly)
         puts (hits.to_f - hrs.to_f) / (atbats.to_f - ks.to_f - \
            hrs.to_f + sacfly.to_f)
      end

      #
      # Pitching options
      #
      # Earned run average
      # 9 * earned runs allowed / innings pitched
      desc "earnedrunaverage <runs> <ip>",
         "Earned run average"
      def earnedrunaverage(runs, ip)
         puts 9*(runs.to_f / ip.to_f)
      end

      # Walks plus hits per inning pitched 
      # walks + hits / innings pitched
      desc "walksplushits <walks> <hits> <ip>",
         "Walks and hits per inning pitched"
      def walksplushits(walks, hits, ip)
         puts (walks.to_f + hits.to_f) / ip.to_f
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
      desc "fieldingpercentage <putouts> <assists> <errors>",
         "Fielding percentage"
      def fieldingpercentage(putouts, assists ,errors)
         puts (putouts.to_f + assists.to_f) / (putouts.to_f + \
            assists.to_f + errors.to_f)
      end

      # Range factor
      # assists + putouts / games
      desc "rangefactor <assists> <putouts> <games>",
         "Range factor"
      def rangefactor(putouts, assists ,games)
            puts (assists.to_f + putouts.to_f) / games.to_f
      end

      #
      # Team options
      #
      # Bill James Pythagorean expectation formula
      # runs allowed ^ 1.83 / runs scored ^ 1.83
      desc "pythagoreanexpectationformula <runsscored> <runsallowed>",
         "Bill James Pythagorean expectation formula"
      def pythagoreanexpectationformula(runsscored, runsallowed)
         puts (runsscored.to_f**1.83) / (runsscored.to_f**1.83 + \
            runsallowed.to_f**1.83)
      end

=begin
      def initialize(argv)

         # Set defaults
         @options = OpenStruct.new
         @options.verbose = false

         # Parse input
         @options, @args = parse_options(argv)

         @statcalc =  BBmetric::StatCalc.new(@options)
      end

      def run
         if arguments_valid? 
            puts '%.3f' % @statcalc.calculate(@args)
         else
         end
      end
=end

=begin
      protected

      def parse_options(argv)
         OptionParser.new{ |opts|

         opts.banner =  "Usage:\n    bbmetric [options] <arguments>"
         opts.separator "\nOptions: "

         opts.on('-V', '--verbose') { @options.verbose = true }  
         opts.on('-p', '--pretty') { @options.pretty_print = true }  

         #
         # Offensive options
         #
         opts.on('--BA <hits> <atbats>', Array,
                 "Batting average") do |hits,atbats|
            @options.avg = true 
            @options.hits = argv[0]
            @options.atbats = argv[1]
         end
         opts.on('-O <hits> <walks> <hbp> <atbats> <sacfly>',
                 '--onbasepercentage  <hits> <walks> <hbp> <atbats> <sacfly>',
                 "On-Base Percentage") \
         do |hits, walks, hbp, atbats, sacfly|
            @options.obp    = true 
            @options.hits   = argv[0]
            @options.walks  = argv[1]
            @options.hbp    = argv[2]
            @options.atbats = argv[3]
            @options.sacfly = argv[4]
         end
         opts.on('-S <hits> <doubles> <triples> <hrs> <atbats>', 
                 '--slugging <hits> <doubles> <triples> <hrs> <atbats>',
                 "Slugging Percentage") \
         do |hits, doubles, triples, hrs, atbats|
            @options.slg      = true 
            @options.hits     = argv[0]
            @options.doubles  = argv[1]
            @options.triples  = argv[2]
            @options.hrs      = argv[3]
            @options.atbats   = argv[4]
         end
         opts.on('-B <walks> <hrs> <atbats> <ks> <sacfly>', 
                 '--babip <walks> <hrs> <atbats> <ks> <sacfly>',
                 "Batting average on balls in play") \
         do |walks, hrs, atbats, ks, sacfly|
            @options.babip = true
            @options.walks    = argv[0]  
            @options.hrs      = argv[1]
            @options.atbats   = argv[2]
            @options.ks       = argv[3]
            @options.sacfly   = argv[4]
         end

         #
         # Pitching options
         #
         opts.on('-W <walks> <hits> <ip>',
                 '--walksplushits <walks> <hits> <ip>',
                 "Walks and hits per inning pitched") \
         do |walks, hits, ip|
            @options.whip  = true 
            @options.walks = argv[0]
            @options.hits  = argv[1]
            @options.ip    = argv[2]
         end
         opts.on('-E <runs> <ip>', '--earnedrunsaverage <runs> <ip>',
                 "Earned run average") \
         do |runs, ip|
            @options.era   = true 
            @options.runs  = argv[0] 
            @options.ip    = argv[1]  
         end
         opts.on('-D <hrs> <walks> <hbp> <ks> <ip>',
                 '--dice <hrs> <walks> <hbp> <ks> <ip>',
                 "Defense-Independent Component ERA (DICE)") \
         do |hrs,walks,hbp,ks,ip|
            @options.dice  = true
            @options.hrs   = argv[0]
            @options.walks = argv[1]
            @options.hbp   = argv[2]
            @options.ks    = argv[3]
            @options.ip    = argv[4]
         end
         opts.on('-F <hrs> <walks> <ks> <ip>',
                 '--fip <hrs> <walks> <ks> <ip>',
                 "Fielding Independent Pitching") \
         do |hrs,walks,ks,ip|
            @options.fip   = true
            @options.hrs   = argv[0]
            @options.walks = argv[1]
            @options.ks    = argv[2]
            @options.ip    = argv[3]
         end

         #
         # Fielding options
         #
         opts.on('-F <putouts> <assists> <errors>',
                 '--fieldingpercentage <putouts> <assists> <errors>') \
         do |putouts, assists ,errors|
            @options.fp       = true
            @options.putouts  = argv[0] 
            @options.assists  = argv[1] 
            @options.errors   = argv[2] 
         end
         opts.on('-R <assists> <putouts> <games>',
                 '--rangefactor <assists> <putouts> <games>') \
         do |putouts, assists ,errors|
            @options.rf       = true
            @options.assists  = argv[0] 
            @options.putouts  = argv[1] 
            @options.games    = argv[2] 
         end

         #
         # Team options
         #
         opts.on('-P <runsscored> <runsallowed>',
                 '--pythagoreanexp <runsscored> <runsallowed>',
                 'Bill James Pythagorean expectation formula') \
         do |runsscored, runsallowed|
            @options.pye         = true
            @options.runsscored  = argv[0]
            @options.runsallowed = argv[1]
         end

         opts.on_tail("-v", "--version", "Print version number") do
            require "rubygems"
            spec = Gem::Specification::load("../bbmetric.gemspec")
            puts "bbmetric #{spec.version}\n"
            exit
         end

         opts.on_tail("-h", "--help", "Print this help") do
            puts "Calculate basic and advanced baseball stats.\n\n"
            puts opts
            exit
         end
         }.parse!(argv)

         [@options, argv]
      end
=end

=begin
      def arguments_valid?
         true if @args.length > 1 
      end
=end

   end
end

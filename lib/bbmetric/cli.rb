module BBmetric
   class Cli
      attr_reader :options

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
            puts @statcalc.calculate(@args)
         else
         end
      end

      protected

      def parse_options(argv)
         OptionParser.new{ |opts|
         
         opts.banner =  "Usage:\n    bbmetric [options] <arguments>"
         opts.separator "\nOptions: "

         opts.on('-V', '--verbose') { @options.verbose = true }  

         # Offensive options
         opts.on('-avg <hits> <atbats>',  '--battingaverage <hits> <at-bats>', 
                 "Batting average") do |hits,atbats|
            @options.avg = true 
            @options.hits = argv[0]
            @options.atbats = argv[1]
         end
         opts.on('-obp <hits> <walks> <hbp> <atbats> <sacfly>',
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
         opts.on('-slg <hits> <doubles> <triples> <hrs> <atbats>', 
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
         opts.on('-babip <walks> <hrs> <atbats> <ks> <sacfly>', 
                 '--battingaverageonballs <walks> <hrs> <atbats> <ks> <sacfly>',
                 "Batting average on balls in play") \
         do |walks, hrs, atbats, ks, sacfly|
            @options.babip = true
            @options.walks    = argv[0]  
            @options.hrs      = argv[1]
            @options.atbats   = argv[2]
            @options.ks       = argv[3]
            @options.sacfly   = argv[4]
         end
         # Pitching options
         opts.on('-whip <walks> <hits> <ip>',
                 '--walksplushits <walks> <hits> <ip>',
                 "Walks and hits per inning pitched") \
         do |walks, hits, ip|
            @options.whip  = true 
            @options.walks = argv[0]
            @options.hits  = argv[1]
            @options.ip    = argv[2]
         end
         opts.on('-era <runs> <ip>', '--earnedrunsaverage <runs> <ip>',
                 "Earned run average") \
         do |runs, ip|
            @options.era   = true 
            @options.runs  = argv[0] 
            @options.ip    = argv[1]  
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

      def arguments_valid?
         true if @args.length > 1 
      end

   end
end

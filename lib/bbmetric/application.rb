module BBmetric
   class Application
      attr_reader :options

      def initialize(argv)

         # Set defaults
         @options = OpenStruct.new
         @options.verbose = false

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
         opts = OptionParser.new 
         opts.on('-V', '--verbose') { @options.verbose = true }  

         # Stat options
         opts.on('-ba', '--battingaverage') { @options.ba = true }
         opts.on('-obp', '--onbasepercentage') { @options.obp = true }
         opts.on('-slg', '--slugging') { @options.slg = true }
         opts.on('-whip', '--walksplushits') { @options.whip = true }

         args = opts.parse(argv)
         
         [@options, args]
      end

      def arguments_valid?
         true if @args.length > 1 
      end

   end
end

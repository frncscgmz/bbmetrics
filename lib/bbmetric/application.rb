module BBmetric
   class Application
      attr_reader :options

      def initialize(arguments, stdin)
         @arguments = arguments
         @stdin = stdin

         # Defaults
         @options = OpenStruct.new
         @options.verbose = false 
      end

      def run
         if parsed_options? && arguments_valid? 
            puts "Start at #{DateTime.now}"
         else
         end
      end

      protected

      def parsed_options?
         opts = OptionParser.new 
         opts.on('-V', '--verbose')    { @options.verbose = true }  
         # TO DO - add additional options

         opts.parse!(@arguments) rescue return false

         #process_options
         true      
      end

      def arguments_valid?
         true if @arguments.length == 1 
      end

   end
end

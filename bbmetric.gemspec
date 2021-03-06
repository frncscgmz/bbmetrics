Gem::Specification.new do |s|
   s.name         = 'bbmetric'
   s.version      = '0.0.1'
   s.date         = '2014-04-01'
   s.summary      = 'Baseball data analysis tool'
   s.description  = 'bbmetrics is a baseball data analysis tool with a Unixy flavor'
   s.authors      = ['Francisco Gomez']
   s.email        = 'mail@frncscgmz.me'
   s.files        = ["lib/bbmetric.rb", "lib/bbmetric/cli.rb", 
                     "lib/bbmetric/statcalc.rb"]
   s.executables  = 'bbmetric'
   s.homepage     =
      'https://github.com/frncscgmz/bbmetrics'
   s.license      = 'MIT'

   s.add_dependency('thor')
   s.add_dependency('colorize')
   s.add_development_dependency("rspec")
end

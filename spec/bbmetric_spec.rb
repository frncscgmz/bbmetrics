require 'bbmetric'

describe BBmetric::StatCalc do
   it "calculate batting average" do
      BBmetric::StatCalc.battingaverage(7,99).should eql(0.0707070707070707)
   end

   it "calculate on-base percentage" do
      BBmetric::StatCalc.onbasepercentage(225,36,5,660,5).round(3)\
         .should eql(0.377)
   end
end

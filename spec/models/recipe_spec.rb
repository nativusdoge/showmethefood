require File.dirname(__FILE__) + '/../spec_helper'

describe Recipe do
  describe "Parsing the tweet" do
    it "should parse the tweet upon instantiation" do
      tweet = mock{tweet}
      Recipe.should_receive(:parse)
      Recipe.new(tweet)
    end
  end
end
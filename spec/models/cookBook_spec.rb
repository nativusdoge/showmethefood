require File.dirname(__FILE__) + '/../spec_helper'

describe CookBook do
  describe "Retrieving the latest tweets" do
    it "should retrieve the latest tweets from upon instantiation" do
      tweets = [1,2,3]
      Twitter.should_receive(:user_timeline).and_return(tweets)
      CookBook.new
    end
    
    it "should only retrieve the last 9 tweets from cookpadit account" do
      tweets = [1,2,3]
      Twitter.should_receive(:user_timeline).with("cookpadit", {:count => 9}).and_return(tweets)
      CookBook.new
    end
  end
end
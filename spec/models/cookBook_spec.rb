require File.dirname(__FILE__) + '/../spec_helper'

describe CookBook do
  before do
    Recipe.stub(:new)
  end

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
  
  describe "Creating recipe objects" do
    it "should create a recipe object for each tweet" do
      tweet = mock{tweet}
      tweets = [tweet, tweet, tweet]
      Twitter.stub(:user_timeline).and_return(tweets)
      Recipe.should_receive(:new).exactly(3).times.with(tweet)
      CookBook.new
    end
    
    it "should keep each recipe object in an array" do
      tweet = mock{tweet}
      tweets = [tweet, tweet, tweet]
      Twitter.stub(:user_timeline).and_return(tweets)
      cb = CookBook.new
      cb.recipes.size.should == 3
    end
  end
end
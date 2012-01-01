require File.dirname(__FILE__) + '/../spec_helper'

describe CookBook do
  before do
    @tweet = mock{tweet}
    @tweet.stub(:text).and_return('Yummy food http://yummyfood.com')
    @tweets = [@tweet, @tweet, @tweet]
  end

  describe "Retrieving the latest tweets" do  
    it "should retrieve the latest tweets upon instantiation" do
      Twitter.should_receive(:user_timeline).and_return(@tweets)
      CookBook.new
    end
    
    it "should only retrieve the last 9 tweets from cookpadit account" do
      Twitter.should_receive(:user_timeline).with("cookpadit", {:count => 9}).and_return(@tweets)
      CookBook.new
    end
  end
  
  describe "Creating recipe objects" do
    before do
      Twitter.stub(:user_timeline).and_return(@tweets)
      @recipe = mock{recipe}
      @recipe.stub(:parse)
    end
    
    it "should create a recipe object for each tweet" do
      Recipe.should_receive(:new).exactly(3).times.and_return(@recipe)
      CookBook.new
    end
    
    it "should keep each recipe object in an array" do
      cb = CookBook.new
      cb.recipes.size.should == 3
    end
    
    it "should call parse on each tweet" do
      Recipe.stub(:new).and_return(@recipe)
      @recipe.should_receive(:parse).with(@tweet).exactly(3).times
      CookBook.new
    end
  end
end
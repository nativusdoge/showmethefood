require File.dirname(__FILE__) + '/../spec_helper'

describe CookBook do
  before do
    @tweet = mock{tweet}
    @tweet.stub(:text).and_return('Yummy food http://yummyfood.com')
    @tweets = [@tweet, @tweet, @tweet]
    @cookbook = CookBook.new
  end

  describe "Retrieving the latest tweets" do
    subject { @cookbook.populate }
    
    before do
      @cookbook.stub(:create_recipes)
    end
    
    it "should retrieve the latest tweets" do  
      Twitter.should_receive(:user_timeline).and_return(@tweets)
      subject
    end
    
    it "should only retrieve the last 9 tweets from twitter account" do
      @cookbook.account = 'twitter'
      Twitter.should_receive(:user_timeline).with('twitter', {:count => 9}).and_return(@tweets)
      subject
    end
  end
  
  describe "Creating recipe objects" do
    subject { @cookbook.populate }
    
    before do
      Twitter.stub(:user_timeline).and_return(@tweets)
      @recipe = mock{recipe}
      @recipe.stub(:parse)
    end
    
    it "should create a recipe object for each tweet" do
      Recipe.should_receive(:new).exactly(3).times.and_return(@recipe)
      subject
    end
    
    it "should keep each recipe object in an array" do
      Recipe.stub(:new).and_return(@recipe)
      subject
      @cookbook.recipes.size.should == 3
    end
    
    it "should call parse on each tweet" do
      Recipe.stub(:new).and_return(@recipe)
      @recipe.should_receive(:parse).with(@tweet).exactly(3).times
      subject
    end
  end
end
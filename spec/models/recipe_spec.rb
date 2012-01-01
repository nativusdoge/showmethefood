require File.dirname(__FILE__) + '/../spec_helper'

shared_examples_for "parser" do
  it "should split into a description and url" do
    tweet = mock{tweet}
    tweet.stub(:text).and_return('Yummy food http://yummyfood.com')
    r = Recipe.new
    r.parse(tweet)
    r.description.should == 'Yummy food'
    r.link_url.should == 'http://yummyfood.com'
  end
  
  describe "determining the image url" do
    before do
      @recipe = Recipe.new
      @recipe.link_url = 'http://yummyfood.com'
    end
    
    it "should retrieve the html that contains the image" do
      @recipe.should_receive(:open).with('http://yummyfood.com')
      @recipe.image_url
    end
    
    it "should return a placeholder if there is no image" do
      @recipe.stub(:open).with('http://yummyfood.com').and_return(nil)
      @recipe.image_url.should == 'http://dummyimage.com/290x207&text=Sorry%20no%20picture!'
    end
  
    it "should parse out the image url from the html" do
      document = Hpricot("<div class=\"main_image\"> <a href=\"http://placehold.it/290x207\" class=\"colorbox\"><img alt=\"Yummy food\" src=\"http://placehold.it/290x207\" /></a> </div>")
      @recipe.stub(:open).with('http://yummyfood.com').and_return(document)
      @recipe.image_url.should == "http://placehold.it/290x207"
    end
  end
end

describe Recipe do
  it_should_behave_like "parser"
end
require File.dirname(__FILE__) + '/../spec_helper'

shared_examples_for "parser" do
  describe "splitting the tweet" do
    subject { @recipe.parse(@tweet) }
    
    before do
      @tweet = mock{tweet}
      @tweet.stub(:text).and_return('Yummy food http://yummyfood.com')
      @recipe = Recipe.new
      @recipe.stub(:get_image_url)
    end
    
    it "should split into a description and url" do
      subject
      @recipe.description.should == 'Yummy food'
      @recipe.link_url.should == 'http://yummyfood.com'
    end
    
    it "should only look for http in the url" do
      @tweet.stub(:text).and_return('Yummy food mailto:hello@food.com http://yummyfood.com')
      subject
      @recipe.link_url.should == 'http://yummyfood.com'
    end
  end
  
  describe "determining the image url" do
    subject { @recipe.get_image_url }
    
    before do
      @recipe = Recipe.new
      @recipe.link_url = 'http://yummyfood.com'
    end
    
    it "should retrieve the html that contains the image" do
      Nokogiri::HTML::Document.should_receive(:parse)
      subject
    end
    
    it "should return a placeholder if there is no image" do
      Nokogiri::HTML::Document.stub(:parse).and_return(nil)
      subject.should == 'http://dummyimage.com/290x299&text=Sorry%20no%20picture!'
    end
  
    it "should parse out the image url from the html" do
      document = Nokogiri::HTML("<div class=\"main_image\"> <a href=\"http://placehold.it/290x299\" class=\"colorbox\"><img alt=\"Yummy food\" src=\"http://placehold.it/290x207\" /></a> </div>")
      Nokogiri::HTML::Document.stub(:parse).and_return(document)
      subject.should == "http://placehold.it/290x299"
    end
  end
end

describe Recipe do
  it_should_behave_like "parser"
end
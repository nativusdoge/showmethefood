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
end

describe Recipe do
  it_should_behave_like "parser"
end
class Recipe
  include Parser
  
  attr_accessor :description, :link_url, :image_url
  
  def initialize(tweet)
    Recipe.parse(tweet)
  end
  
end
class CookBook
  attr_accessor :recipes
  
  def initialize
    @recipes = []
    tweets = Twitter.user_timeline("cookpadit", {:count => 9})
    create_recipes(tweets)
  end
  
  private
  
  def create_recipes(tweets)
    tweets.each do |tweet|
      recipe = Recipe.new
      recipe.parse(tweet)
      @recipes << recipe 
    end
  end
end
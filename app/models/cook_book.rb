class CookBook
  attr_accessor :recipes, :tweets, :account
  
  def initialize
    @account = 'cookpadit'
    @recipes = []
  end
  
  def populate
    retrieve_tweets
    create_recipes
  end
  
  private
  
  def retrieve_tweets
    @tweets = Twitter.user_timeline(@account, {:count => 9})
  end
  
  def create_recipes
    @tweets.each do |tweet|
      recipe = Recipe.new
      recipe.parse(tweet)
      @recipes << recipe 
    end
  end
end
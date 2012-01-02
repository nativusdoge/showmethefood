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
  
  def randomize
    retrieve_tweets(100)
    @tweets = @tweets.sample(6)
    create_recipes
  end
  
  private
  
  def retrieve_tweets(count = 6)
    @tweets = Twitter.user_timeline(@account, {:count => count})
  end
  
  def create_recipes
    @tweets.each do |tweet|
      recipe = Recipe.new
      recipe.parse(tweet)
      @recipes << recipe 
    end
  end
end
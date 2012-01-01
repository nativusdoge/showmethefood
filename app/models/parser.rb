module Parser
  def parse(tweet)
    @description = tweet.description.split('http').first.strip
    @link_url = URI.extract(tweet.description).first
  end
end
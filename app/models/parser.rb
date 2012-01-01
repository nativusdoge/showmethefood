module Parser
  def parse(tweet)
    @description = tweet.text.split('http').first.strip
    @link_url = URI.extract(tweet.text).first
  end
end
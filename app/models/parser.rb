require 'open-uri'

module Parser
  def parse(tweet)
    @description = tweet.text.split('http').first.strip
    @link_url = URI.extract(tweet.text).first
  end
  
  def image_url
    document = open(@link_url) { |f| Hpricot(f) }
    if document
      element = document.at("//div[@class='main_image']//a[@href]")
      element[:href]
    else
      'http://dummyimage.com/290x207&text=Sorry%20no%20picture!'
    end
  end
end
require 'open-uri'

module Parser
  def parse(tweet)
    @description = tweet.text.split('http').first.strip
    @link_url = URI.extract(tweet.text, 'http').first
    @image_url = get_image_url if @link_url
  end
  
  def get_image_url
    document = Nokogiri::HTML(open(@link_url))
    element = document.xpath("//div[@class='main_image']//a[@href]")
    element.attribute('href').value
  rescue Exception
    'http://dummyimage.com/290x299&text=Sorry%20no%20picture!'
  end
end
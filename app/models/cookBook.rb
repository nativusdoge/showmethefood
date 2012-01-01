class CookBook
  def initialize
    @tweets = Twitter.user_timeline("cookpadit", {:count => 9})
  end
end
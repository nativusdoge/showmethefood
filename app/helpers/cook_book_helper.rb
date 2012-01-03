module CookBookHelper
  def shorten_description(description)
    if description.size > 40
      description.slice(0..36) + '...'
    else
      description
    end
  end
end
class CookBooksController < ApplicationController

  def index
    @cookBook = CookBook.new

    respond_to do |format|
      format.html
    end
  end

end

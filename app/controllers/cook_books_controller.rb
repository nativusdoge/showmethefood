class CookBooksController < ApplicationController

  def index
    @cookBook = CookBook.new
    @cookBook.populate

    respond_to do |format|
      format.html
    end
  end

end

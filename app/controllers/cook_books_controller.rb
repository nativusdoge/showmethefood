class CookBooksController < ApplicationController

  def index
    @cookBook = CookBook.new
    if params[:random]
      @cookBook.randomize
    else
      @cookBook.populate
    end
    
    respond_to do |format|
      format.html
    end
  end
  
end

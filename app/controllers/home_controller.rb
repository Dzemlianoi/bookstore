class HomeController < ApplicationController
  def index
    @categories = Category.all.where('count_books > 0').order('count_books DESC')
  end
end

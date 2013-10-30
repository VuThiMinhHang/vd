class MyPagesController < ApplicationController
  def home
    if signed_in?
      @book  = current_user.books.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 3)
    end
   end
 end

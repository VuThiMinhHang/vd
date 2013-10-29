class BooksController < ApplicationController
  before_action :signed_in_user, only: [:index, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @all_id_books = []
    Book.all.each do |book| 
      if book.user.status? || current_user?(book.user)
        @all_id_books << book
      end
    end
    @all_books = Book.where(:id => @all_id_books).paginate(page: params[:page], per_page: 3)

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Book updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Book created!"
      redirect_to root_url
    else
      @feed_item = []
      render 'my_pages/home'
    end
  end


  def destroy

    Book.find(params[:id]).destroy
    flash[:success] = "Book deleted!"
    redirect_to root_url
  end


private

    def book_params
      params.require(:book).permit(:name, :description)
    end

  def correct_user
        @book = current_user.books.find_by(id: params[:id])
        redirect_to root_url if @book.nil?
  end
end


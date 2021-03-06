class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :can_show?, only: :show

  def show
    @user = User.find(params[:id])
    @books = @user.books.paginate(page: params[:page], per_page: 3)
  end

  def can_show?
    user = User.find(params[:id])
     if ( signed_in?)
      if(current_user != (user))
          if(!user.status)
            flash[:erros] = "List Book private"
            redirect_to root_url
          end
      else
        #ishhvsgh
      end
     else
     redirect_to signin_url  
   end

  end

  def update
    @user = User.find(params[:id])
    @user.status = params[:user][:status]
    if @user.update_attributes(user_params)
      flash[:success] = "Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

    def feed
    books
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Book Management!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

      # Before filters

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end

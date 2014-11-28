class AccountsController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    #@users = self.search(params, User)
    @users = User.all
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def edit
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to action: "index", :notice => "user saved with success" 
    else
      respond_with(@user)  
    end
  end

  def update
    @user = User.new(user_params)
    @user.save
    render :json => user_params
  end

  def destroy
    @user.destroy
    redirect_to action: "index"
  end

  private
	  def set_user
	    @user = User.find(params[:id])
	  end
	 
	  def user_params
	    params.require(:user).permit(:name, :email, :password, :password_confirmation)
	  end

end
class AccountsController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
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
      redirect_to action: "index"
    else
      respond_with(@user)  
    end
  end

  #FIXME Fazer validações para edicao de usuario
  #
  def update
    @user = User.new(user_params)
    @user.update(:name => params[:name])
    redirect_to action: "index"
  end

  def activate_user
    @user = User.find(params[:id])
    @user.update(:active => true)
    redirect_to action: "index"
  end 

  def inactivate_user
    @user = User.find(params[:id])
    @user.update(:active => false)
    redirect_to action: "index"
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
	    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
	  end

end

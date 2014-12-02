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
    
    @user.active = true
    @user.admin = false

    if @user.valid?
      @user.save
      redirect_to action: "index"
    else
      respond_with(@user)  
    end

  end

  def update_user_account

    @user = User.find(params[:id])

=begin
    @user = User.new(user_params)
    if @user.password == @user.password_confirmation && !@user.password.blank?

      if @user.valid?
        @aux.update(:name => @user.password, :password => @user.password)
      else
        respond_with(@user)
        return
      end

    else
      
      if @user.password != @user.password_confirmation && !@user.password.blank?
        @user.errors.add(:INFO, "A confirmação de senha falhou. Por favor tente novamente.")
        respond_with(@user)
        return
      else
         @aux.update(:name => @user.name)
      end

    end
=end

    @user.update(:name => params[:user][:name])
    
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

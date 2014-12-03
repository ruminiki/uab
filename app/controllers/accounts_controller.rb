class AccountsController < ApplicationController

  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @users = User.where.not(id: current_user.id)
    #respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.admin = false
    @user.active = true
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update_user_account

    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(user_params)
      flash[:error] = "Usuário atualizado com sucesso!"
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end

  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Usuário removido com sucesso!"
      redirect_to :action => 'index'
    end
  end 

  def activate_user
    @user = User.find(params[:id])
    if @user.update(:active => true)
      flash[:notice] = "Usuário ativado com sucesso!"
    else
      flash[:error] = "Erro ao ativar usuário!"
    end
    redirect_to action: "index"
  end 

  def inactivate_user
    @user = User.find(params[:id])
    if @user.update(:active => false)
      flash[:notice] = "Usuário inativado com sucesso!"
    else
      flash[:error] = "Erro ao inativar usuário!"
    end
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

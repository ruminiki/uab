class AccountsController < ApplicationController

  respond_to :html

  def index
    @users = User.all
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
    @user = User.new(user_params)
    @user.admin = false
    @user.active = true
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to :action => 'index'
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

  def authorizations
    @user = User.find(params[:id])
    @use_cases = UseCase.all

    #verifica se o usuario já possui a autorização
    @use_cases.each do |use_case|

      if !has_use_case_authorization(use_case.id, @user.id)

        auth = Authorization.new
        auth.use_case = use_case
        auth.user = @user

        @user.authorizations << auth

        @user.save
            
      end
      
    end

    render '_form_authorizations'

  end

  def has_use_case_authorization(use_case_id, user_id)
    authorization = User.joins(:authorizations)
    .where('authorizations.use_case_id = ? and authorizations.user_id = ?', use_case_id, user_id)

    !authorization.nil? && authorization.length > 0
  end

  def update_authorization
    @auth = Authorization.find(params[:authorization_id])

    add    = params[:add].nil? ? false : true
    edit   = params[:edit].nil? ? false : true
    view   = params[:view].nil? ? false : true
    remove = params[:remove].nil? ? false : true

    @auth.update(:add => add, :edit => edit, :view => view, :remove => remove)

    #recupera o usuário para recarregar o form
    @user = User.joins(:authorizations).find(params[:user_id])

    render '_form_authorizations'
  end

  private
	  def set_user
	    @user = User.find(params[:id])
	  end
	 
	  def user_params
	    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin, :active)
	  end

end

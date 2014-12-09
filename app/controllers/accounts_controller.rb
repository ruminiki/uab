  class AccountsController < ApplicationController

  respond_to :html
  autocomplete :role, :name

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

  def roles
    @user = User.find(params[:id])
    render '_form_roles'
  end

  def add_role

    @user = User.find(params[:id])
    #impede que uma mesma role seja adicinada mais de uma vez para o mesmo usuário
    if role_already_added(params[:user][:role_id], params[:id])
      render '_form_roles'
      return
    end

    #limpa os erros que podem existir da requisição anterior
    @user.errors.clear

    begin
      @role = Role.find(params[:user][:role_id])
    rescue
      @user.errors.add(:info, "Papel não encontrado. Por favor selecione um papel válido. ")
    end
    
    #if occurred any erros, back to page
    if @user.errors.any?
      render '_form_roles'
      return
    end

    @user.roles << @role
    #@role.users << @user
    @user.save

    redirect_to :back, :notice => "Papel adicionado com sucesso!"  
 
  end

  def role_already_added(role_id, user_id)
    role = User.joins(:roles).where('roles.id = ? and users.id = ?', role_id, user_id)
    !role.nil? && role.length > 0
  end

  def remove_role
    @user = User.find(params[:id])
    @user.roles.delete(params[:role_id])
    @user.save
    redirect_to :back, :notice => "Papel removido com sucesso!"
  end

  private
	  def set_user
	    @user = User.find(params[:id])
	  end
	 
	  def user_params
	    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin, :active)
	  end

end

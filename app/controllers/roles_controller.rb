class RolesController < ApplicationController
  
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :close_window, only: [:index]
  respond_to :html, :xml, :json

  include ModelSearchHelper
  include ModelAddForSelectHelper
  
  def index
    @roles = self.search(params, Role)
    respond_with(@roles)
  end

  def show
    respond_with(@role)
  end

  def new
    @role = Role.new
    respond_with(@role)
  end

  def edit
  end

  def create
     @role = Role.new(role_params)
    if @role.valid?
      @role.save
      redirect_to action: "index", :alert => "Papel salvo com sucesso!" 
    else
      respond_with(@role)
    end
  end

  def update
    @role.update(role_params)
    redirect_to action: "index"
  end

  def destroy
    @role.destroy
    respond_with(@role)
  end

  def clear_search
    session.delete :search_role_name
    redirect_to action: "index"
  end

  def authorizations
    @role = Role.find(params[:id])
    @use_cases = UseCase.all

    #verifica se o usuario já possui a autorização
    @use_cases.each do |use_case|

      if !has_use_case_authorization(use_case.id, @role.id)

        auth = Authorization.new
        auth.use_case = use_case
        auth.role = @role

        @role.authorizations << auth

        @role.save
            
      end
      
    end

    render 'authorizations/_form'

  end

  def has_use_case_authorization(use_case_id, role_id)
    authorization = Role.joins(:authorizations)
    .where('authorizations.use_case_id = ? and authorizations.role_id = ?', use_case_id, role_id)

    !authorization.nil? && authorization.length > 0
  end

  def update_authorization
    @auth = Authorization.find(params[:authorization_id])

    add    = params[:add].nil? ? false : true
    edit   = params[:edit].nil? ? false : true
    view   = params[:view].nil? ? false : true
    remove = params[:remove].nil? ? false : true

    @auth.update(:add => add, :edit => edit, :view => view, :remove => remove)

    #recupera a role para recarregar o form
    @role = Role.joins(:authorizations).find(params[:role_id])

    render 'authorizations/_form'
  end 

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name)
    end
end

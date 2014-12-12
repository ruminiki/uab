class RolesController < ApplicationController
  
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :close_window, only: [:index]
  respond_to :html, :js, :json

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
      redirect_to action: "authorizations", :id => @role.id
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

    session["url_back_authorizations"] = request.referrer
    #se o usuario esta na tela de manutencao de roles habilita a edicao do contrario desabilita
    @edit = (request.referrer.end_with? "/roles") || (request.referrer.end_with? "/roles/new")

    render 'authorizations/_form'

  end

  def has_use_case_authorization(use_case_id, role_id)
    authorization = Role.joins(:authorizations)
    .where('authorizations.use_case_id = ? and authorizations.role_id = ?', use_case_id, role_id)

    !authorization.nil? && authorization.length > 0
  end

  def update_authorization
    #lista todos os use_cases para fazer a atualização de todos de uma só vez
    @use_cases = UseCase.all

    #percorre os use_cases
    @use_cases.each do |use_case|
      #verifica se para o use_case corrent existe alguma autorização
      param = params[use_case.key + 'authorization_id']
      if !param.nil?
        #carrega a autorização salva para o use case corrente
        @auth = Authorization.find(param)

        #recupera os parâmetros da requisição
        add    = params[use_case.key + '_add'].nil? ? false : true
        edit   = params[use_case.key + '_edit'].nil? ? false : true
        view   = params[use_case.key + '_view'].nil? ? false : true
        remove = params[use_case.key + '_remove'].nil? ? false : true

        #atualiza o use_case
        @auth.update(:add => add, :edit => edit, :view => view, :remove => remove)
      end

    end

    #recupera a role para recarregar o form
    #@role = Role.joins(:authorizations).find(params[:role_id])  
    
    redirect_to roles_path
  end 

  private
    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:name)
    end
end

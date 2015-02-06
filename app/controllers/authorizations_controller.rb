class AuthorizationsController < ApplicationController
  before_action :set_authorization, only: [:show, :edit, :update, :destroy]

  def index
    @authorizations = Authorization.all
    @total = Authorization.distinct.count('id')
    respond_with(@authorizations)
  end

  def show
    respond_with(@authorization)
  end

  def new
    @authorization = Authorization.new
    respond_with(@authorization)
  end

  def edit
  end

  def create
    @authorization = Authorization.new(authorization_params)
    @authorization.save
    respond_with(@authorization)
  end

  def update
    @authorization.update(authorization_params)
    respond_with(@authorization)
  end

  def destroy
    @authorization.destroy
  end

  private
    def set_authorization
      @authorization = Authorization.find(params[:id])
    end

    def authorization_params
      params.require(:authorization).permit(:user_id, :use_case_id, :add, :edit, :view, :delete)
    end
end

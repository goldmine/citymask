class RolesController < ApplicationController
  before_filter :check_admin_role, :find_user
  
  def index
    @roles = Role.all
  end
  
  def update
    @role = Role.find(params[:id])
    unless @user.has_role?(@role.name)
      @user.roles << @role
    end
    redirect_to :action => "index"
  end
  
  def destroy
    @role = Role.find(params[:id])
    if @user.has_role?(@role.name)
      @user.roles.delete(@role)
    end
    redirect_to :action => "index"
  end
  
  protected
  def find_user
    @user = User.find(params[:user_id])
  end
end

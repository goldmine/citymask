class UsersController < ApplicationController
  before_filter :check_admin_role,
                :only => [:index, :enable, :destroy]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @entries = Entry.find_all_by_user_id(@user)
  end

  def new
    @user = User.new
  end
  
  def show_by_name
    @user = User.find_by_username(params[:username])
    render :action => 'show'
  end

  def create
    @user = User.new(params[:user])
      @user.save!
      self.logged_in_user = @user
      flash[:notice] = "注册成功！"
      redirect_to index_url
    rescue ActiveRecord::RecordInvalid
      render :action => 'new'
  end

  def edit
    @user = logged_in_user              
  end

  def update
    @user = User.find(logged_in_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "更新成功！"
      redirect_to :action => "show", :id => logged_in_user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attributes(:enabled, false)
      flash[:notice] = "该用户被禁止！"
    else
      flash[:error] = "无法禁止该用户！"
    end
    redirect_to :action => "index"
  end

  def enable
    @user = User.find(params[:id])
    if @user.update_attributes(:enabled, true)
      flash[:notice] = "该用户被解禁！"
    else
      flash[:error] = "无法解禁该用户！"
    end
    redirect_to :action => "index"
  end

end

class AccountController < ApplicationController
  def login
    if is_logged_in? 
      redirect_to index_url 
    end
  end

  def authenticate
    self.logged_in_user = User.authenticate(params[:user][:username], params[:user][:password])
    if is_logged_in?
      flash[:notice] = "登陆成功！转到首页！"
      redirect_to index_url
    else
      flash[:error] = "登陆信息不正确，请重试！"
      redirect_to :action => "login"
    end
  end

  def logout
    if request.post?
      reset_session
      flash[:notice] = "成功退出！"
      redirect_to(index_url)
    end
  end

end

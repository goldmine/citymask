module  LoginSystem
  protected
  
  def is_logged_in?
    @logged_in_user = User.find(session[:user]) if session[:user]
  end
  
  def logged_in_user
    return @logged_in_user if is_logged_in?
  end
  
  def logged_in_user=(user)
    if !user.nil?
      session[:user] = user.id
      @logged_in_user = user
    end
  end
  
  def self.included(base)
    base.send :helper_method, :is_logged_in?, :logged_in_user
  end
  
  def check_role(role)
    unless is_logged_in? && @logged_in_user.has_role?(role)
      flash[:error] = "你没有权限执行！"
      redirect_to login_url
    end
  end
  
  def check_admin_role
    check_role('Administrator')
  end
  
  def check_moderator_role
    check_role('Moderator')
  end
  
  def login_required
    unless is_logged_in?
      respond_to do |wants|
        wants.html do
          flash[:error] = "你必须先登陆！."
          redirect_to :controller => 'account', :action => 'login'
        end
        wants.xml do
          headers["Status"]           = "Unauthorized"
          headers["WWW-Authenticate"] = %(Basic realm="Web Password")
          render :text => "Could't authenticate you", 
                 :status => '401 Unauthorized', 
                 :layout => false    
        end
      end
    end
  end
end
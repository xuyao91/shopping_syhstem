class Admin::AdminController < Admin::AdminBaseController
  # Be sure to include AuthenticationSystem in Application Controller instead
  
  # If you want "remember me" functionality, add this before_filter to Application Controller
  #before_filter :login_from_cookie

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || Admin.count > 0
  end

  def login
    return unless request.post?
    self.current_admin = Admin.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_admin.remember_me
        cookies[:auth_token] = { :value => self.current_admin.remember_token , :expires => self.current_admin.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/admin/product', :action => 'index')
      flash[:notice] = "Logged in successfully"
    else
      redirect_back_or_default(:controller => 'admin/admin', :action => 'login')
      flash[:notice]="用户名或密码错误，请重新登陆！"
    end
  end

  def signup
    @admin = Admin.new(params[:admin])
    return unless request.post?
    @admin.save!
    self.current_admin = @admin
    redirect_back_or_default(:controller => '/admin/product', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end
  
  def logout
    self.current_admin.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(:controller => '/admin/admin', :action => 'login')
  end
  

# 
  # 显示个人信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6    
  def personal_info
  end

  
  # 修改密码
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def reset_password
    @admin = Admin.find_by_id(params[:id])
    unless @admin.present?
      flash[:notice]="操作错误！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
  end
  
  # 更新修改的密码
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def password_update
    pass = Admin.authenticate(current_admin.login, params[:old_password])
    if pass.present?
      if (params[:new_password]==params[:new_password_confirm])        
        current_admin.crypted_password = current_admin.encrypt(params[:new_password])
        current_admin.save!
        flash[:notice]="修改成功！" 
        redirect_to :action => "personal_info"
      elsif params[:new_password]!= params[:new_password_confirm]      
        flash[:notice]="两次密码不一样，修改失败！"
        render :action => "reset_password"
      end
     else
      flash[:notice]="修改失败！"
      render :action => "reset_password"
    end
    
  end  


  # 编辑个人信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6  
  def personal_edit
    @admin = Admin.find_by_id(params[:id])
    unless @admin.present?
      flash[:notice]="操作错误！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
  end
  
  
  # 更新个人信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6  
  def personal_update
    @admin = Admin.find(params[:id])
    @admin.update_attributes(params[:admin])
    if @admin.valid?
      @admin.save!
      flash[:notice]="修改成功！"
      redirect_to :action => "personal_info"
    else
      flash[:notice]="修改失败！"
      render :action => "personal_edit"
    end
    
  end
  
  
  # 设置信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6   
  def set    
  end
  
  # 添加管理用户
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def add_admin 
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    end
  end
  
  # 添加管理用户
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def create_admin
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
      @admin = Admin.new(params[:admin])
      @admin.crypted_password = @admin.encrypt(params[:new_password])
      if @admin.valid?
        @admin.save!
        flash[:notice]="添加成功！"
        redirect_to :action => "set"
      else
        flash[:notice]="添加失败！"
        render :action => "add_admin"
      end
   end
  end
  
  
  # 显示所有后台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def admin_user
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
      @admin_users = Admin.paginate(:all, :conditions => ["id > ?", 1], :per_page => 5, :page => (params[:page || 1]))
    end
  end
  
  # 编辑后台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def admin_user_edit
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
    @admin_user =  Admin.find_by_id(params[:id])
    unless @admin_user.present?
      flash[:notice]="操作错误，没有此用户信息！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
  end
  end
  
  # 更新后台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def admin_user_update
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
      @admin_user = Admin.find(params[:id])
      if params[:new_password].present? 
        @admin_user.update_attributes(params[:admin_user])
        @admin_user.crypted_password = @admin_user.encrypt(params[:new_password])
      else
        @admin_user.update_attributes(params[:admin_user])
      end
      
      if @admin_user.valid?
        @admin_user.save!
        flash[:notice]="修改成功！"
        redirect_to :action => "admin_user"
      else
        flash[:notice]="修改失败！"
        render :action => "admin_user_edit"
      end
    end
  end
  
  # 删除后台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def admin_user_delete
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
      @admin_user = Admin.find(params[:id])
      if @admin_user.present?
        @admin_user.destroy
        flash[:notice]="删除成功！"
      else
        flash[:notice]="删除失败！"
      end
      redirect_to :action => "admin_user"
    end
  end
  
  
  # 批量删除后台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_all_admin_user
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
      @ids = params[:admin_user_id]
      if @ids.present?
        admin_users = Admin.find(:all, :conditions => [" id in (?)", @ids])
        if admin_users.present?
          admin_users.each do |p|
            p.destroy
          end
          flash[:notice]="删除成功！"
        else
            flash[:notice]="删除失败！"
        end
      else
        flash[:notice]="抱歉，你还没选择！"
      end
      redirect_to :action => "admin_user"
    end
  end

end

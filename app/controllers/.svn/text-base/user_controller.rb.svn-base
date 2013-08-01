class UserController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller
  before_filter :login_from_cookie
  layout 'logo', :except=> [:login,:signup]

  # say something nice, you goof!  something sweet.
  def index  
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0 
    if logged_in?
      @user = User.find(current_user.id)
      @user_image = UserAttachment.find(:first,:conditions=>["owner_id = ?",current_user.id])
    else
      redirect_to :controller=>'/user',:action => 'login'     
    end   
  end

   # modifiy of the user's infomations
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def edit
    @user = User.find(current_user.id)
    @user_image = UserAttachment.find(:first,:conditions=>["owner_id = ?",current_user.id])
    if(request.post?)
      # @user.update_attributes!(params[:user])     
      @user.login = params[:user][:login]
      @user.gender = params[:gender]
      @user.tel = params[:user][:tel]
      @user.age = params[:user][:age]
      @user.email = params[:user][:email]
      if @user.valid?  
        @user.save!       
      else
        render :action =>:edit
        return 
      end
      if @user_image.blank?  
        if params[:user][:image].present?
          user_attachment = UserAttachment.new
          file_name =Attachment.image_preview(params[:user][:image])
          file_path = "/public/images/"     
          user_attachment.owner_id = @user.id
          user_attachment.file_name = file_name
          user_attachment.file_path = file_path 
          Attachment.change_image(file_name)
          user_attachment.save!
        end
      else
        if params[:user][:image].present?
          @user_image.file_name = UserAttachment.image_preview(params[:user][:image])
          Attachment.change_image(@user_image.file_name)
          @user_image.save!
        end
      end
      flash[:notice] = "修改成功"
      redirect_to :action => 'index'
    end    
  end

  # login of the user
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def login
    return unless request.post?
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default(:controller => '/product', :action => 'index')
      flash[:notice] = "登录成功"
   else
     flash[:notice]="用户名或密码错误！" 
    end
  end

  # register users
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def signup
    @user = User.new
    return unless request.post?
      @user.login = params[:user][:login]
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.gender = params[:gender]
      @user.tel = params[:user][:tel]
      @user.age = params[:user][:age]
      @user.email = params[:user][:email]    
      @user.save!
    self.current_user = @user
    redirect_back_or_default(:controller => '/user', :action => 'index')
    flash[:notice] = "Thanks for signing up!"
#    flash[:login] = @user.login
#    flash[:password] = @user.password
    SentMail.deliver_sent(@user,@user.password)
    rescue ActiveRecord::RecordInvalid
    render 
  end
 
  # logout of the user
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    @cart = session[:cart]
    if @cart.present?
    @items = @cart.items
      if @items.present?
        @items.each do |item|
          sec_product = Product.find(:first, :conditions=>["id = ?",item.product.id])
          sec_product.quantity += item.quantity.to_i
          sec_product.save!
        end
      end
    end
    reset_session
    flash[:notice] = "您已经安全退出"
    redirect_back_or_default(:controller => '/product', :action => 'index')
  end
 
  # modifiy the user's password
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def edit_password
    return unless request.post?
    pass = User.authenticate(current_user.login, params[:old_password])
    if pass.present?
      if params[:new_password].present? && params[:new_password_confirm].present?     
        if (params[:new_password] == params[:new_password_confirm])
          current_user.crypted_password = current_user.encrypt(params[:new_password])
          current_user.save!
          flash[:notice]="修改成功！"     
        else 
          flash[:notice]="两次密码不一致，无法修改！"
        end
      else
        flash[:notice] = "新密码不能为空，修改失败！" 
      end  
    else
      flash[:notice]="初始密码错误，修改失败！"
    end
    redirect_to :action => "index"
  end

  # add the picture for the user
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def add_image
    render :update do |page|
      text = render :partial => "user_image"
      page.replace_html 'change_image', text
    end
  end
  
  # Pictures preview path
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-1-11
  def image_preview
    @image_name = Attachment.image_preview(params[:user][:image])
    responds_to_parent do
      render :update do |page|
        page.replace_html "image_preview", (render :partial => 'image_preview')
      end
    end
  end
  
end

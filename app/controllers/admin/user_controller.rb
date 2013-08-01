class Admin::UserController < Admin::AdminBaseController
 
 # 查看所有用户
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30
  def index
    #@users = User.find(:all)
    @users = User.paginate(:all, :per_page => 5, :page => (params[:page || 1]), :order => "id desc")
  end
  
  
  # 查看用户详细信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30
  def detail
    @user = User.find_by_id(params[:id])
    unless @user.present?
      flash[:notice]="操作错误，没有此用户信息！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
    user_attachment = UserAttachment.find_by_owner_id(@user.id)
    if user_attachment.present?
      user_image = user_attachment.file_name
      @image = Attachment.get_image("temp_image", user_image)
    else
      @image = "fork.png"
    end
  end
  
  
  # 删除用户账号
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30
  def delete
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => "index"
  end

  # 编辑前台用户
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-7
  def edit
    @user = User.find_by_id(params[:id])
    unless @user.present?
      flash[:notice]="操作错误，没有此用户信息！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
    user_attachment = UserAttachment.find_by_owner_id(@user.id)
    if user_attachment.present?
      user_image = user_attachment.file_name
      @image = Attachment.get_image("temp_image", user_image)
    else
      @image = "fork.png"
    end
  end
  
   # 更新前台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-7
  def update
    @user = User.find(params[:id])
    if params[:new_password].present?
      @user.update_attributes(params[:user])      
      @user.crypted_password = @user.encrypt(params[:new_password])
    else
      @user.update_attributes(params[:user])
    end
    
    if @user.valid?
      @user.save!      
      user_attachment = UserAttachment.find(:first, :conditions => ["owner_id = ?", @user.id])
      if user_attachment.present?
      else
        user_attachment = UserAttachment.new
      end
      
      if params[:commodity].present?
        file_name = UserAttachment.image_preview(params[:commodity][:image])
        file_path = "/public/images/"     
        user_attachment.owner_id = @user.id
        user_attachment.file_name = file_name
        user_attachment.file_path = file_path 
        Attachment.change_image(file_name)
        user_attachment.save! 
    end
#      flash[:login] = @user.login
#      flash[:password] = params[:new_password]
      SentMail.deliver_sent_edit(@user,params[:new_password]) rescue ActiveRecord::RecordInvalid
      flash[:notice]="修改成功！" 
     redirect_to :action => "index"
    else
      user_attachment = UserAttachment.find_by_owner_id(@user.id)
      if user_attachment.present?
        user_image = user_attachment.file_name
        @image = Attachment.get_image("temp_image", user_image)
      else
        @image = "fork.png"
      end
      flash[:notice]="修改失败！"
      render :action => "edit"
    end
    end

  
   # 更换用户的头像信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-7
  def change_user_image
    render :update do |page|
      text = render :partial => 'user_image'
      page.replace_html 'user_image', text
    end
  end
  
  # 添加用户账号
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-7
  def add    
  end
  
  def create
    @user = User.new
    @user.login = params[:user][:login]
    @user.crypted_password = @user.encrypt(params[:user][:new_password])
    @user.email = params[:user][:email]
    @user.gender = params[:user][:gender]
    @user.age = params[:user][:age]
    @user.tel = params[:user][:tel]
    if @user.valid?
        @user.save!        
     else
        flash[:notice]="添加失败！"
        render :action => "add"
        return
    end  
    if params[:commodity].present?
      user_attachment = UserAttachment.new
      file_name = UserAttachment.image_preview(params[:commodity][:image])
      file_path = "/public/images/"     
      user_attachment.owner_id = @user.id
      user_attachment.file_name = file_name
      user_attachment.file_path = file_path 
      Attachment.change_image(file_name)
      user_attachment.save!
    end
    flash[:notice]="添加成功！"
    redirect_to :action => "index"
  end
  
  
  # 图片预览路径
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-7
  def image_preview
    @image_name = Attachment.image_preview(params[:commodity][:image])
    responds_to_parent do
      render :update do |page|
        page.replace_html "image_preview_1", (render :partial => '/admin/user/image_preview')
      end
    end
  end
  
  # 批量删除用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_all
    @ids = params[:user_id]
    if @ids.present?
      users = User.find(:all, :conditions => [" id in (?)", @ids])
      if users.present?
        users.each do |p|
          p.destroy
        end
        flash[:notice]="删除成功！"
      else
          flash[:notice]="删除失败！"
      end
    else
      flash[:notice]="抱歉，你还没选择！"
    end
    redirect_to :action => "index"
  end 
  
  # 动态添加用户图像
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-12
  def add_user_image
    render :update do |page|
      text = render :partial => "user_image"
      page.replace_html 'user_image', text
    end
  end
 
end
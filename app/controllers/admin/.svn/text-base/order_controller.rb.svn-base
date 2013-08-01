class Admin::OrderController < Admin::AdminBaseController
 # 显示所有的订单信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30  
  def index
    if current_admin.id != 1
      flash[:notice]="非法访问！"
      redirect_to :controller => '/admin/product', :aciont => :index
    else
      @orders = Order.paginate(:all, :conditions => ["flag = ?", 0], :per_page => 8, :page => (params[:page || 1]), :order => "created_at desc")
    end
  end
 
  # 删除订单的信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-4   
  def delete
    @order = Order.find(params[:id])
    if @order.present?
      @order.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => "index"
  end
  
  # 显示订单的详细信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-4  
  def detail
    @order = Order.find_by_id(params[:id])
    unless @order.present?
      flash[:notice]="操作错误，没有此用户信息！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
    product_attachment = Attachment.find_by_owner_id(@order.product_id)
    if product_attachment.present?
      image_name = product_attachment.file_name
      @image = Attachment.get_image("small_images", image_name)
    else 
      @image = "fork.png"
    end
  end
  
  # 订单的相关处理
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-5   
  def deliver
    @order = Order.find(params[:id])
    @user = User.find(:first, :conditions => ["id = ?", @order.user_id]) 
    @product = Product.find(:first, :conditions => ["id = ?", @order.product_id])
    if @order.present?
      @order.flag = true
      @order.save!
      SentMail.deliver_sent_order(@user, @product, @order) rescue ActiveRecord::RecordInvalid
      flash[:notice]="货物已发送！"
    else
      flash[:notice]="发送失败！"
    end
  end
  
  # 删除后台用户信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def history_order
    @orders = Order.paginate(:all, :conditions => ["flag = ?", 1], :per_page => 8, :page => (params[:page || 1]), :order => "updated_at desc")
    render :update do |page|
      text = render :partial => "show_history_order"
      page.replace_html 'history_order1', text
    end
  end
 
  # 批量删除订单信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_all
    @ids = params[:order_id]
    if @ids.present?
      orders = Order.find(:all, :conditions => [" id in (?)", @ids])
      if orders.present?
        orders.each do |order|
          order.destroy
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
 
 
end

class UserAddressController < ApplicationController
  
  layout 'logo'
  before_filter :login_required
  
  # If the user login, shows users used address before
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-13
  def index
    @user_address_1 = UserAddress.find(:all,:conditions=>["user_id = ?",current_user.id]).collect{|g| ["#{g.name},#{g.address.scan(/./)[0,12].join+"..."},#{g.code},#{g.tel}",g.id]}
    if params[:id].present?
      @product = Product.find(params[:id])
      if params[:count].present?
        if Regexp.new('[1-9][0-9]{0,1}').match(params[:count]).to_s.eql?(params[:count])
          if @product.quantity <= params[:count].to_i
            flash[:notice] = "对不起，库存不足" 
            redirect_to :controller => "/product", :action => 'detail',:id=>@product.id
          else
            @quantity = params[:count]
          end
        else
          flash[:notice] = "请输入两位数以内的正整数"
          redirect_to :controller => "/product", :action => 'detail', :id=>params[:id]
        end
      else
        @quantity = 1
        if @product.quantity <= @quantity
            flash[:notice] = "对不起，库存不足" 
            redirect_to :controller => "/product", :action => 'detail',:id=>@product.id
        end
      end
    else
      @cart = session[:cart]
      @items = @cart.items
      @sum = 0
      @items.each do |item|
        @sum  += item.quantity.to_i*item.product.price.to_i
      end
    end  
    
  end
  
  # change the user's address
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-13
  def change_user_address
    @user_address = UserAddress.find(:first,:conditions=>["id = ?",params[:user_address_id]])
    render :update do |page|
      text = render :partial=>'user_address'
      page.replace_html 'user_address_1',text
    end
  end
  
  # Fill in the  address
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-05
  def add_user_address  
    @user_address = UserAddress.find(:all, :conditions => ["user_id = ?",current_user.id])
    if params[:user_address][:name].present? && params[:user_address][:address].present? && params[:user_address][:code].present? && params[:user_address][:tel].present?
      if params[:user_address][:id] == ""  || @user_address.blank?
        @add_user_address = UserAddress.new
        @add_user_address.user_id = current_user.id
        @add_user_address.name = params[:user_address][:name]
        @add_user_address.address = params[:user_address][:address]
        @add_user_address.code = params[:user_address][:code]
        @add_user_address.tel = params[:user_address][:tel]
        @add_user_address.save!
        flag = true
      else
        @user_address = UserAddress.find(:first,:conditions=>["id = ?",params[:user_address][:id]])
        @user_address.user_id = current_user.id
        @user_address.name = params[:user_address][:name]
        @user_address.address = params[:user_address][:address]
        @user_address.code = params[:user_address][:code]
        @user_address.tel = params[:user_address][:tel]
        @user_address.save!      
        flag = false
      end
      @cart = session[:cart] 
      if @cart.present?
        @items = @cart.items
      end
      if params[:product_id].present?    
        product = Product.find(:first,:conditions=>["id = ?",params[:product_id]])
        order = Order.new
        order.user_id = current_user.id
        order.product_id = params[:product_id]
        if params[:product_count].present?
          order.total_price = product.price.to_i*params[:product_count].to_i
        else
          order.total_price = product.price
        end
        order.count = params[:product_count].to_i
        if flag == true
          order.user_address_id = @add_user_address.id
        else
          order.user_address_id = params[:user_address][:id]
        end         
        order.save!
        product.quantity -= params[:product_count].to_i
        product.save!
      else
        if @items.present?     
          @items.each do |item|
            order = Order.new
            product = Product.find(:first,:conditions=>["id = ?",item.product.id])
            order.user_id = current_user.id 
            order.product_id = item.product.id
            order.total_price = item.product.price.to_i * item.quantity.to_i
            order.count = item.quantity
            if flag == true
              order.user_address_id = @add_user_address.id
            else
              order.user_address_id = params[:user_address][:id]
            end         
            order.save!
            product.save!
          end
          session[:cart] = nil 
        end      
      end
      render :update do |page|
        message = flash[:notice] = "提交成功"
        page.replace_html 'show_message',message
        page.redirect_to :controller => "/order", :action => :index   
      end   
    else
      render :update do |page|
        message = flash[:notice] = "请填写完整信息！"
        page.replace_html 'show_message',message
       # page.redirect_to :action =>'index'
      end
    end
  end
  
  def list_address
    @address = UserAddress.find(:all,:conditions=>["user_id= ?",current_user.id])
  end
  
  def del_address
    if params[:id].present?
      @address = UserAddress.find(:first,:conditions=>["id= ?",params[:id]])
      @address.destroy
      flash[:notice] = "删除成功！"
      redirect_to :action=>'list_address'   
    else
      flash[:notice] = "操作有误！"
      redirect_to :action=>'list_address'
    end
  end
 
  def edit
    @user_address = UserAddress.find(:first,:conditions=>["id= ? and user_id= ?",params[:id],current_user.id])
    if @user_address.present?
      if(request.post?)
        @user_address.attributes = params[:user_address]
        if @user_address.valid? 
          @user_address.save!
          flash[:notice] = "修改成功"
          redirect_to :action=>'list_address'
        else
          render :action=>'edit' 
          return
        end
      end
    else
      flash[:notice]="对不起,您请求的页面不存在！"
      redirect_to :action=>'list_address'
    end
  end

end

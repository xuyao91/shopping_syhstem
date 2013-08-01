class ProductController < ApplicationController
  
   before_filter :login_required,:only=>[:add_pro_collect]
   layout 'logo'
 
  # find all the products
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2011-12-30
  def index
    @products = Product.paginate(:all, :per_page =>15,:page =>(params[:page ]||1),:order =>'created_at desc')
    @sub_genre_arrs = SubGenre.all.collect{|g| [g.sub_name, g.id]}
    @genre_arrs = Genre.all.collect{|g| [g.name, g.id]}
    cookies[:info] = "" unless cookies[:info].present?
  end
 
  # select the product
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2011-12-30
  def search  
    conn = Product.get_condition(params)
    @products = Product.paginate(:all,:conditions=>conn,:include =>:genre, :per_page =>15,:page =>(params[:page ]||1)) 
    @genre_arrs = Genre.all.collect{|g| [g.name, g.id]}
    @sub_genre_arrs = SubGenre.all.collect{|g| [g.sub_name, g.id]}
    if @products.blank?
      flash[:notice] = "糟糕，您要的商品好像没有找到，看看其它商品吧！"
      redirect_to :action=>'index'
    end   
  end
 
  # detail of the product
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2011-12-30
  def detail
    sum_score = 0
    @ave_score = 0.0
    flag = true
    begin
    @product = Product.find(params[:id])
    @like_product_image = []
    @product_images =  ProductAttachment.find(:all,:conditions=>["owner_id = ?",params[:id]])
    @like_products = Product.find(:all,:conditions=>["products.genre_id = ? and id != ?",@product.genre_id,@product.id], :limit=>5)
    @reviews = Review.paginate(:all, :order => "created_at DESC", :conditions=>["product_id=?",params[:id]],:per_page=>6,:page=>(params[:page]||1))
    @result = Review.count :conditions => ["product_id = ?",params[:id]]
    sum_score = Review.sum :score,:conditions => ["product_id = ?",params[:id]]
    @ave_score = sum_score / @result if @result > 0 
  rescue
    flash[:notice] = "抱歉，您请求的页面无法打开，系统自动跳转到首页"
    redirect_to :action=>'index'
  end 
  browses = cookies[:info]
  if browses.split('/').present?
    if browses.split('/').size < 5
      @browse_products = Product.find(browses.split('/'))
    else
      @browse_products = Product.find(browses.split('/')[-5,5])
    end
    browses.split('/').each do |id|
      if id == params[:id]
        flag = false
        break
      end
    end
    browses << "#{params[:id]}/" if flag == true
  else
    browses << "#{params[:id]}/"
  end
  cookies[:info] = browses
  end
  
  # add the review of the user
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2011-12-30
  def add_review
    if logged_in?
      order = Order.find(:first,:conditions=>["user_id = ? and product_id = ?",current_user.id,params[:id]])
      if order.present?
        if params[:review][:content].present?
          review = Review.new(params[:review])
          review.content = params[:review][:content]
          review.user_id = current_user.id
          review.product_id = params[:id]
          review.score = Product.get_score(params[:score])
          review.save!
          @reviews = Review.all(:order => "created_at DESC", :conditions=>["product_id=?",params[:id]])
          render :update do |page|
            message = flash[:notice] = "评论成功！"
            text = render :partial => "show_review"
            page.replace_html "show_review", text
            page.replace_html "show_message", message
            page.remove "show_text"
          end
        else   
          render :update do |page|
            message = flash[:notice] = "评论不能为空噢！"
            page.replace_html "show_message", message
          end  
        end
      else
        render :update do |page|
          message = flash[:notice] = "对不起，您还没有购买此商品，无法评论！"
          page.replace_html "show_message", message
          page << "document.getElementById('review_content').value = ' '"
        end  
      end
    else
      render :update do |page|
        page.redirect_to :controller => '/user',:action => 'login'
      end
    end 
  end

  # add the product to collect
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2011-12-31
  def add_pro_collect
    @pro_collect = ProCollect.find(:first,:conditions=>["user_id = ? and product_id = ?",current_user.id,params[:id]])
    if @pro_collect.present? 
      flash[:notice] = "您已经收藏过该商品了！"
    else     
      add_pro_collect = ProCollect.new
      add_pro_collect.user_id = current_user.id
      add_pro_collect.product_id = params[:id]
      add_pro_collect.save!    
      flash[:notice] = "收藏成功！"       
    end
    redirect_to :action=>'detail',:id=>params[:id]
  end
 

  # find products from the cart
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-01
  def cart
    @cart = find_cart
    @items = @cart.items
    @sum = 0
    @items.each do |item|
      @sum  += item.quantity.to_i*item.product.price.to_i
    end
  end

  # add the product into the cart
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-01
  def add_to_cart 
    @cart = find_cart 
    product = Product.find(params[:id])
    if product.quantity <= 0
      flash[:notice] = "对不起，库存不足"
      redirect_to :action=> 'detail',:id=>params[:id]
    else
      @cart.add_product(product)
      flash[:notice] = "已加入购物车"
      redirect_to :action=> 'cart'
    end   
  end
  
  def delete_cart
    @cart = find_cart
    @cart.delete_product(params[:id].to_i) 
    flash[:notice] = "删除成功！"
    redirect_to :action=>'cart'
  end
 
  def load_modify
    @product_id = params[:id]
    @count = params[:count]
    render :update do |page|
      text = render :partial=>"modify"
      page.replace_html "modify_count_#{params[:id]}",text
    end
  end
  # Modify the quantity of a commodity  in the shopping cart
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-06
  def modify  
    @cart = find_cart
    @items = @cart.items
    product = Product.find(:first,:conditions=>["id = ?",params[:id]])
    if Regexp.new('[1-9][0-9]{0,1}').match(params[:modify_count]).to_s.eql?(params[:modify_count])
      current_item = @items.find{|i| i.product == product}
      product.quantity =  product.quantity.to_i + current_item.quantity.to_i
      if product.quantity >= params[:modify_count].to_i
        @items.each do |item|
          if item.product.id == params[:id].to_i           
            product.save!
            item.quantity = params[:modify_count] 
          end       
        end     
        product.quantity = product.quantity.to_i - params[:modify_count].to_i
        product.save!
      else
        flash[:notice] = "对不起，库存不足，请重新选择数量！"
      end
    else
      flash[:notice] = "请输入两位数以内的正整数"
    end
    redirect_to :action=>'cart'
    #render :action => 'cart'
  end

  # browse the genre of products
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-04
  def genre
    @sub_genre = SubGenre.find(:all,:conditions=>["genre_id = ?",params[:id]])
    @products = Product.paginate(:all,:conditions=>["genre_id = ?", params[:id]], :per_page =>15,:page =>(params[:page ]||1))
  end
  
  # browse the sub_genre of products
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-04
  def sub_genre
    @products = Product.paginate(:all,:conditions=>["sub_genre_id = ?",params[:id]], :per_page =>15,:page =>(params[:page ]||1))
    begin
      sub_genre = SubGenre.find_by_id(params[:id])
      @genre = Genre.find_by_id(sub_genre.genre_id)
      @sub_genres = SubGenre.find(:all, :conditions => ["genre_id = ?", @genre.id])
    rescue
      flash[:notice] = "抱歉，您请求的页面无法打开，系统自动跳转到首页"
      redirect_to :action=>'index'
    end
  end
 
  # change the sub_genre of products
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def change_sub_genre
    if params[:genre_id].present?
      genre = Genre.find(params[:genre_id])
      @sub_genre_arrs = genre.sub_genres.collect{|g| [g.sub_name,g.id]}
    end
      render :layout => false
  end 
  
  # new a cart of session
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2011-12-31
  private
  def find_cart
    unless session[:cart]
      session[:cart] = Cart.new
    end
     session[:cart]
  end
end

class Admin::ProductController < Admin::AdminBaseController
   before_filter :valid_post_requested, :only =>[:update, :create]
  
  # 确认访问方式
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def valid_post_requested
    unless request.post? 
      flash[:notice]="非法访问！"
      redirect_to :action => :index
    return
    end
  end
  
  # 查看所有商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def index
    #@products = Product.all()
    @products = Product.paginate(:all, :per_page => 10 ,:page =>(params[:page || 1]), :order => "id desc") 

  end
  
  # 添加商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def add    
    @options = Genre.all.collect{|g| [g.name, g.id]}
    @options1 = SubGenre.all.collect{|s| [s.sub_name, s.id]}
  end
  
  # 创建商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def create
    @product = Product.new(params[:product])
    file_path = "public/images"
    if @product.valid?       
      @product.save!
      if params[:arr].present?
        @file_name = []
        params[:arr].each do |arr|
          file_name = ProductAttachment.image_preview(params[arr]) 
          @file_name << file_name
        end
        @file_name.each do |f|
          product_attachment = ProductAttachment.new
          product_attachment.owner_id = @product.id
          product_attachment.file_name = f
          product_attachment.file_path = file_path
          Attachment.change_image(f)
          product_attachment.save!
        end
      end
      flash[:notice]="添加成功！"
      redirect_to :action => :index    
    else
      @options = Genre.all.collect{|g| [g.name, g.id]}
      @options1 = SubGenre.all.collect{|s| [s.sub_name, s.id]}
      render :action => "add"
    end
  end
  
  # 编辑商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29        
  def edit   
    @product = Product.find_by_id(params[:id])
    unless @product.present?
      flash[:notice]="操作有误，编辑的商品不存在！"
      redirect_to :action => "index"
      return
    end
    @options = Genre.all.collect{|g| [g.name, g.id]}
    @options1 = SubGenre.all.collect{|s| [s.sub_name, s.id]}
    product_attachments = ProductAttachment.find(:all, :conditions => ["owner_id = ?", @product.id])
      if product_attachments.present?
        @images = []
        product_attachments.each do |product_attachment|
          product_image = product_attachment.file_name
          @images << Attachment.get_image("middle_images", product_image)
        end
#      else
#        @image = "fork.png"
      end
  end
  
  # 编辑中删除商品图片
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def edit_delete_product_image
    product_attachment = ProductAttachment.find(:first, :conditions => ["owner_id = ?", params[:id]])
    if product_attachment.present?
      product_attachment.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => "edit", :id=> params[:id]
  end
  
  # 更新商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def update 
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    file_path = "public/images"
    if @product.valid? 
      @product.save!
      if params[:arr].present?
        @product_image_name = []
        params[:arr].each do |arr|
          file_name = ProductAttachment.image_preview(params[arr])
          @product_image_name << file_name
        end
        @product_image_name.each do |product_image_name|
          product_attachment = ProductAttachment.new
          product_attachment.owner_id = @product.id
          product_attachment.file_name = product_image_name
          product_attachment.file_path = file_path
          Attachment.change_image(product_image_name)
          product_attachment.save!     
        end
        
      end 
      flash[:notice]="修改成功！"
      redirect_to :action => :index
    else
      flash[:notice]="修改失败！"
      render :action => "edit"
    end    
    
  end
  
  # 删除商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def delete
    @product = Product.find(params[:id])
    if @product.present?
      @product.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => :index
  end
  
  # 大分类和小分类直接的关系
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def get_relative_scate
    @sub_genres = SubGenre.find(:all, :conditions => ["genre_id = ?", params[:id]])
    render :update do |page|
      page.replace_html 'td', render(:partial => "sub_genre")
    end
  end 
  
  # 一张图片的图片预览路径
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def image_preview1
    @image_name = Attachment.image_preview(params[:commodity][:image])
    responds_to_parent do
      render :update do |page|
        page.replace_html "image_preview", (render :partial => '/admin/product/image_preview')
      end
    end
  end
  
  # 商品详细信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def detail
     @product = Product.find_by_id(params[:id])
     unless @product.present?
      flash[:notice] = "操作有误，查看的产品不存在"
      redirect_to :action => "index"
      return
    end    
     @reviews = Review.find(:all, :conditions => ["product_id = ?", params[:id]])
      product_attachments = ProductAttachment.find(:all, :conditions => ["owner_id = ?", @product.id])
      if product_attachments.present?
        @images = []
        product_attachments.each do |product_attachment|
          image_name = product_attachment.file_name
          @images << Attachment.get_image("temp_image", image_name)
        end
      else
        @image = "fork.png"
      end
  end
  
  # 搜索商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30  
  def search
      @conn = Product.get_condition(params)
      @products = Product.paginate(:all,:conditions => @conn, :include => [:genre, :sub_genre], :page => (params[:page || 1]), :per_page => 2)
      render :controller => '/admin/product', :action => 'index'
  end 
  
  # 编辑时动态的修改商品图像
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def change_product_image
    render :update do |page|
      text= render :partial=> "product_image"
      page.replace_html 'product_image', text
    end
  end
  
  
  # 动态给商品添加图像
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def add_product_image
    render :update do |page|
      text = render :partial => "product_image"
      page.replace_html "add_product_image", text
    end
  end
  
  # 批量删除商品信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-9
  def delete_all
    @ids = params[:product_id]
    if @ids.present?
      products = Product.find(:all, :conditions => [" id in (?)", @ids])
      if products.present?
        products.each do |p|
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
  
  
  # 动态添加商品预览
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def add_preview
    @file_id = params[:file_id].to_i
    render :update do |page|
      page.insert_html :bottom, 'upload_image', :partial => '/admin/product/upload_image'
      page.replace_html 'link', (link_to_remote '添加图片', :url => {:controller => "/admin/product", :action => "add_preview", :file_id => @file_id + 1})
    end
  end
  
  # 多图片预览路径
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def image_preview
    if params["image_#{params[:file_id]}"].present?
      @image_name = Attachment.image_preview(params["image_#{params[:file_id]}"])
      responds_to_parent do
        render :update do |page|
          page.replace_html "image_preview_#{params[:file_id]}", (render :partial => '/admin/product/image_preview')
        end
      end
    else return
   end
  end
  
  # 删除图片预览
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_preview
    @file_id = params[:file_id].to_i
    render :update do |page|
      page.remove "file_field_#{@file_id}"
    end
  end

  
  #详细中 删除商品图片
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_product_image
    product_attachment = ProductAttachment.find(:first, :conditions => ["owner_id = ?", params[:id]])
    if product_attachment.present?
      product_attachment.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => "detail",:id => params[:id]
  end
  
end



















class Admin::ReviewController < Admin::AdminBaseController
 
 # 所有商品的评价列表
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30  
  def index
    #@reviews = Review.find(:all)
    @reviews = Review.paginate(:all, :per_page => 8, :page => (params[:page || 1]), :order => "id desc")
  end
 
  
  # 删除商品的评论
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30 
  def delete
    @review = Review.find(params[:id])
    if @review.present?
      @review.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => "index"
  end
  
  # 显示详细的评价内容
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30   
  def detail
    @review = Review.find_by_id(params[:id])
    unless @review.present?
      flash[:notice]="操作错误，没有此评论！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
    product_attachment = Attachment.find_by_owner_id(@review.product_id)
      if product_attachment.present?
        image_name = product_attachment.file_name
        @image = Attachment.get_image("middle_images", image_name)          
      else
       @image = "/public/images/rails.png"
      end
  end
  
  # 批量删除评论信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_all
    @ids = params[:review_id]
    if @ids.present?
      reviews = Review.find(:all, :conditions => [" id in (?)", @ids])
      if reviews.present?
        reviews.each do |p|
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
 
 
end
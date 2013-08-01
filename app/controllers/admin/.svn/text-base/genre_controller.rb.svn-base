class Admin::GenreController < Admin::AdminBaseController
  
  # 显示所有分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def index
    #@genres = Genre.find(:all)
    @genres = Genre.paginate(:all, :per_page => 5, :page => (params[:page || 1]))
  end
  
  # 添加分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def add_genre    
  end  

  def create_genre
    @genre = Genre.new(params[:genre])
      if @genre.valid?
        @genre.save!
        flash[:notice]="添加成功！"
        redirect_to :action => :index
      else
        render :action => :add_genre
      end
  end
  
  # 编辑分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def edit
    @genre = Genre.find_by_id(params[:id])
    unless @genre.present?
      flash[:notice]="操作错误，没有此信息！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
  end
  
  # 更新分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-13
  def update
    @genre = Genre.find(params[:id])
    @genre.update_attributes(params[:genre])
    if @genre.valid? 
      @genre.save!
      flash[:notice]="修改成功！"
      redirect_to :action => :index
    else
     # flash[:notice]="修改失败！"
      render :action => "edit"
    end    
    
  end
  
  # 删除分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def delete
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to :action => :index
  end
  
  # 某一分类下的所有商品
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30
  def genre_product_list
    #@products = Product.find(:all, :conditions => ["genre_id = ?", params[:id]])
    @products = Product.paginate(:all, :conditions => ["genre_id = ?", params[:id]], :per_page => 2, :page => (params[:page || 1]))
  end
  
  # 添加小分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def add_sub_genre    
  end
  
  # 新建小分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def create_sub_genre
    
    @sub_genre = SubGenre.new(params[:sub_genre])
    @sub_genre.genre_id=params[:product][:genre_id]
    if @sub_genre.valid?
      @sub_genre.save!
      flash[:notice]="添加成功！"
      redirect_to :action => "sub_genre_list"
    else
      #flash[:notice]="添加失败！"
      render :action => "add_sub_genre"
    end
   
 end
 
  # 小分类列表
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def sub_genre_list
#    @sub_genres = SubGenre.all
    @sub_genres = SubGenre.paginate(:all, :per_page => 5, :page => (params[:page || 1]), :order => "id desc")
  end
  
  # 编辑小分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def sub_genre_edit
    @sub_genre = SubGenre.find_by_id(params[:id])
    unless @sub_genre.present?
      flash[:notice]="操作错误，没有此信息！"
      redirect_to :controller => "/admin/product", :action => "index"
      return
    end
  end
  
  # 更新小分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def sub_genre_update
    @sub_genre = SubGenre.find(params[:id])
    @sub_genre.update_attributes(params[:sub_genre])
    if @sub_genre.valid?
      @sub_genre.save!
      flash[:notice]="修改成功！"
      redirect_to :action => "sub_genre_list"
    else
     # flash[:notice]="修改失败！"
      render :action => "sub_genre_edit"
    end
    
  end
  
  # 删除小分类
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-6
  def sub_genre_delete
    @sub_genre = SubGenre.find(params[:id])
    if @sub_genre.present?
      @sub_genre.destroy
      flash[:notice]="删除成功！"
    else
      flash[:notice]="删除失败！"
    end
    redirect_to :action => "sub_genre_list"
  end
  
  # 批量删除大分类并级联小分类信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_all_genre
    @ids = params[:genre_id]
    if @ids.present?
      genres = Genre.find(:all, :conditions => [" id in (?)", @ids])
      if genres.present?
        genres.each do |p|
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
  
  # 批量删除小分类信息
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-1-11
  def delete_all_sub_genre
    @ids = params[:sub_genre_id]
    if @ids.present?
      sub_genres = SubGenre.find(:all, :conditions => [" id in (?)", @ids])
      if sub_genres.present?
        sub_genres.each do |p|
          p.destroy
        end
        flash[:notice]="删除成功！"
      else
          flash[:notice]="删除失败！"
      end
    else
      flash[:notice]="抱歉，你还没选择！"
    end
    redirect_to :action => "sub_genre_list"
  end  
  
  
end

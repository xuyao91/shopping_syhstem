class ProCollectController < ApplicationController
  
  layout 'logo' 
  before_filter :login_required
  # find prodcuts that user has been collect
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-05
  def index
    @pro_collects = ProCollect.paginate(:all,:conditions=>["user_id = ?",current_user.id],:per_page =>8,:page =>(params[:page ]||1), :order=>"created_at DESC")
  end

  
  # delete the product that user has been collect
  #【引数】
  #【返値】
  #【注意】
  #【著作】XY-2012-01-05
  def delete
    @pro_collect = ProCollect.find(:first,:conditions=>["product_id = ?",params[:id]])
    @pro_collect.destroy
    redirect_to :action=>'index'
  end
end

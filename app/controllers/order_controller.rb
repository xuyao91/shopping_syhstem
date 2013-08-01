class OrderController < ApplicationController
  layout 'logo'
  before_filter :login_required
  def index
    @orders = Order.paginate(:all, :conditions=>["user_id = ?",current_user.id], :per_page=>10, :page =>(params[:page ]||1), :order=>"created_at DESC")
  end

  # delete the user's order
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2011-01-11
  def delete
    if params[:id].present?
      order = Order.find(params[:id])
      order.destroy
      flash[:notice] = "删除成功！"
      redirect_to :action=>'index'
    end
  end

  # delete the a lot of orders
  #【引数】
  #【返値】
  #【注意】
  #【著作】xy 2012-02-24
  def delete_some
    if Order.delete_products(params[:id])
      flash[:notice] = "批量删除成功！"
    else
      flash[:notice] = "请选择要删除的商品"
    end    
    redirect_to :action=>'index'
  end
end

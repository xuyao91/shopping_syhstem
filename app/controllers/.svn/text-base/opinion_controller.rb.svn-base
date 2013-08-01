class OpinionController < ApplicationController
 
  before_filter :login_required
  
# add the user's opinions of agree
#【引数】
#【返値】
#【注意】
#【著作】xy 2011-01-16
  def agree
    opinion_find = Opinion.find(:first,:conditions=>["review_id = ? and user_id = ?",params[:review_id],current_user.id])
    if opinion_find.present?
      flash[:notice] = "此评论您已经投过票了！"
    else
      opinion = Opinion.new
      opinion.review_id = params[:review_id]
      opinion.user_id = current_user.id
      opinion.opinion = true
      opinion.save!
      flash[:notice] = "投票成功！"
    end
    redirect_to :controller =>'/product', :action => :detail, :id => params[:id]
  end
  
# add the user's opinions of against
#【引数】
#【返値】
#【注意】
#【著作】xy 2011-01-16
  def against
    opinion_find = Opinion.find(:first,:conditions=>["review_id = ? and user_id = ?",params[:review_id],current_user.id])
    if opinion_find.present?
      flash[:notice] = "此评论您已经投过票了！"
    else
      opinion = Opinion.new
      opinion.review_id = params[:review_id]
      opinion.user_id = current_user.id
      opinion.save!
      flash[:notice] = "投票成功！"
    end
    redirect_to :controller =>'/product', :action => :detail, :id => params[:id]
  end
  
end

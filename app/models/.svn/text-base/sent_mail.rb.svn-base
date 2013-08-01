class SentMail < ActionMailer::Base
  
   def password_reset(user)
       @recipients = xuyao1991@live.cn   # 收件人邮箱
       @from = xy@alpha-it-system  # 发件人邮箱
       @subject = base64("This is the test of usermail")  # 邮件主题
       @sent_on = Time.now   # 发送时间
       @body[:str] = user.password    # 邮件内容 
   end
   
   def sent(user,password)
     @subject = "新用户激活"
     @body[:user] = user
     @body[:password] = password
     @recipients = user.email
     @from =   'xuyao9123@sina.com' # 发件人邮箱
     @sent_on = Time.now   # 发送时间
     @headers = {}
     @content_type = 'text/html'
  end
 
  def sent_edit(user,password)
     @subject = "获取密码"
     @body[:user] = user
     @body[:password] = password
     @recipients = user.email
     @from =   'guanbin_1989@126.com' # 发件人邮箱
     @sent_on = Time.now   # 发送时间
     @headers = {}
     @content_type = 'text/html'
  end
 
   def sent_order(user, product, order)     
      @subject = "发货订单"
      @body[:user] = user.login
      @body[:name] = product.name
      @body[:price] = product.price
      @body[:count] = order.count
      @body[:total_price] = order.total_price
      @recipients = user.email
      @from = 'guanbin_1989@126.com'
      @sent_on = Time.now
      @headers = {}
      @content_type = 'text/html'
   end

end
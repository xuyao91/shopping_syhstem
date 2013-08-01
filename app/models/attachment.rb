class Attachment < ActiveRecord::Base
  acts_as_paranoid
  
  SMALL_PHOTO = {:size => 40, :path => 'small_images' }
  MIDDLE_PHOTO = {:size => 150, :path => 'middle_images'}
  
  # 创建图片预览路径
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-30
  def self.image_preview(file)
    file_name = UUID.random_create.to_s + File.extname(file.original_filename)
    file_path = "#{RAILS_ROOT}/public/upload_images/temp_image/"
    real_path = file_path + file_name
    FileUtils.mkdir_p(file_path) unless File.exist?(file_path)
    File.delete(real_path) if File.exist?(real_path)
    File.open(file_path + file_name, "wb" ) do |f|
      f.write(file.read)
    end
    return file_name
  end
  
  # 获取图片的路径
  #【引数】
  #【返値】
  #【注意】
  #【著作】gb 2011-12-29
  def self.get_image(file, name)
    "/upload_images/#{file}/" + name
  end
  
  #设置压缩图片的比例
  #【引数】参数
  #【返値】返回值
  #【注意】备注
  #【著作】gb 2011-1-4
  def self.set_size(original_image , min_size = 80)
     height = original_image.rows
     width = original_image.columns
     # 如果width 大于height ， width缩小的80 ， height =  （80*实际宽度）/实际高度
     size = width >= height ? [min_size , (min_size*height.to_f)/width.to_f] :  [ (min_size*width.to_f)/height.to_f , min_size] 
     return size
  end
 
  #压缩图片的路径设置
  #【引数】参数
  #【返値】返回值
  #【注意】备注
  #【著作】gb 2011-1-5 
 def self.change_image(image_name)
    original_image = Magick::Image.read("#{RAILS_ROOT}/public/upload_images/temp_image/" + image_name).first
    [SMALL_PHOTO, MIDDLE_PHOTO].each do |photo|
      img_size = Attachment.set_size(original_image, photo[:size])
      width,height = img_size[0], img_size[1]
      resize_image = original_image.resize(width, height)
      FileUtils.mkdir_p("#{RAILS_ROOT}/public/upload_images/#{photo[:path]}") unless File.exist?("#{RAILS_ROOT}/public/upload_images/#{photo[:path]}")
      resize_image.write("#{RAILS_ROOT}/public/upload_images/#{photo[:path]}/#{image_name}")
    end
  end 
 
 
end


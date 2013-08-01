class Product < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :genre
  belongs_to :sub_genre
  has_many :product_attachments, :foreign_key => :owner_id
  has_many :reviews, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :pro_collects, :dependent => :destroy
  
  validates_presence_of :name, :price, :quantity
  validates_uniqueness_of :name  
  validates_length_of :describe, :minimum => 2
  validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :price
 
  def self.get_condition(params)
      conn = [[]]
      if params[:product][:genre_id].present?
        conn[0] << "genre_id = ?"
        conn << params[:product][:genre_id].to_i
      end
      
      if params[:product][:sub_genre_id].present?
        conn[0] << "sub_genre_id = ?"
        conn << params[:product][:sub_genre_id].to_i
      end
       
      if params[:product].present? && params[:product][:name].present?
        conn[0] << "products.name like ? or products.describe like ?"
        conn << "%#{(params[:product][:name]).strip}%"
        conn << "%#{params[:product][:name].strip}%"
      end    
      conn[0] = conn[0].join(' and ')
      return conn
      
  end
 
  def self.get_score(choice)
    case choice
      when "one"
      score = 1
      when "two"
      score = 2
      when "three"
      score = 3
      when "four"
      score = 4
      when "five"
      score = 5
    end
    return score
  end
  
  def add_to_new_browse(products_id)
    new_browse_array = products_id.to_s.split(',').collect(&:to_i)
    if new_browse_array.include?(self.id)
      new_browse_array.delete(self.id)
    else
      new_browse_array.delete_at(14) if new_browse_array.size == 15        
    end    
    new_browse_array.unshift(self.id)
    new_browse_array.join(',')
  end
  
end

class Genre < ActiveRecord::Base
  acts_as_paranoid
  has_many :products
  has_many :sub_genres, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
end

class SubGenre < ActiveRecord::Base
  acts_as_paranoid
  has_many :products
  belongs_to :genre
  
  validates_presence_of :sub_name
  validates_uniqueness_of :sub_name
end

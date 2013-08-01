class Review < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :product
  belongs_to :user
  has_many :opinions 
end

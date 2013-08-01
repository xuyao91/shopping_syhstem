class UserAddress < ActiveRecord::Base
  acts_as_paranoid
  validates_presence_of :name,:address,:code,:tel
  validates_numericality_of :code,:only_integer => true,:if => proc{|u| u.code.present?}
  validates_numericality_of :tel,:only_integer => true,:if => proc{|u| u.tel.present?}
end

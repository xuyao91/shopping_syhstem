require 'digest/sha1'
class User < ActiveRecord::Base
  acts_as_paranoid
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  has_many :reviews
  has_many :pro_collects
  has_many :orders
  has_many :opinions
  has_many :user_attachments, :foreign_key => :owner

  validates_presence_of     :login, :email,:age,:tel
  validates_presence_of     :password,                   :if => :password_required? 
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required? &&  proc{|u| u.password.present?}
  validates_confirmation_of :password,                   :if => :password_required? &&  proc{|u| u.password_confirmation.present?}
  validates_length_of       :login,    :within => 3..40, :if => proc{|u| u.login.present?}
  validates_length_of       :email,    :within => 3..100, :if => proc{|u| u.email.present?}
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  validates_format_of       :email, :if => proc{|u| u.email.present?},  
                                    :with => /^([A-Za-z0-9\(-|+|_|.)]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , 
                                    :message => "Mail format is not correct"                                      
  validates_numericality_of :age,:only_integer => true,:if => proc{|u| u.age.present?}
  validates_numericality_of :tel,:only_integer => true,:if => proc{|u| u.tel.present?}
  validates_length_of       :tel, :is => 11, :if => proc{|u| u.tel.present?}  
  
  before_save :encrypt_password 

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      crypted_password.blank? || !password.blank?
    end
end

require 'digest/sha1'
class Admin < ActiveRecord::Base
  acts_as_paranoid
  # Virtual attribute for the unencrypted password
  attr_accessor :password
  
  
  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :is => 6, :if => :password_required? && proc{|u| u.password.present?}
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,     :within => 2..20, :too_long => "用户名太长", :too_short => "用户名太短", :if => proc{|u| u.login.present?}
  validates_length_of       :email,    :within => 3..100, :if => proc {|u| u.email.present?}
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password
  validates_format_of       :email,    :with => /^([A-Za-z0-9\(-|+|_|.)]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , 
                                       :message => "邮箱格式不正确", :if => proc{|u| u.email.present?}
  validates_format_of :login, :with => /^[a-zA-Z][a-zA-Z0-9_]{4,15}$/, :message => "格式不正确", :if => proc{|u| u.login.present?}
  
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
  
  def self.create_default
    admin = Admin.new
    admin.login = 'admin'
    admin.crypted_password = '4145b5e509e769f5b3092015de6eefc1c7ee0058'
    admin.salt = '65e23a75720c8ba5bc4f20a069c51070c2e32f04'
    admin.save!
  end
  
  
end

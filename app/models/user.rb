require 'digest/sha2'
class User < ActiveRecord::Base
  attr_protected :hashed_password, :enabled
  attr_accessor :password
  
  validates_presence_of :username,  :message => "昵称不能为空!"
  validates_presence_of :email,  :message => "Email不能为空!"
  validates_presence_of :password,  :message => "密码不能为空!", :if => :password_required?
  validates_presence_of :password_confirmation,  :message => "密码不能为空!", :if => :password_required?
  
  validates_confirmation_of :password,  :message => "密码不符！", :if => :password_required?
  validates_uniqueness_of :username,  :message => "昵称已经被使用！", :case_sensitive => false
  validates_uniqueness_of :email,  :message => "Email已经被使用！", :case_sensitive => false
  validates_format_of :email, :with => /^([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,  :message=>"Email地址好像不对！."
  
  validates_length_of :email, :within => 3..100
  validates_length_of :username, :within => 3..64,  :message => "昵称不能太长！"
  validates_length_of :password, :within => 6..20,  :message => "密码长度不符！"
  
  has_and_belongs_to_many :roles
  
  has_many :topics
  has_many :posts
  has_many :comments
  has_many :entries
  has_many :albums
  has_many :photos, :through => :albums, :extend => TagCountsExtension
  
  
  
  def before_save
    self.hashed_password = User.encrypt(password) if !self.password.blank?
  end
  
  def password_required?
    self.hashed_password.blank? || self.password.blank?
  end
  
  def self.encrypt(string)
    return Digest::SHA256.hexdigest(string)
  end
  
  def self.authenticate(username, password) #昵称或者email登陆
    find_by_username_and_hashed_password_and_enabled(username, User.encrypt(password), true) || find_by_email_and_hashed_password_and_enabled(username, User.encrypt(password), true)
  end
  
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
    
end

class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics
  
  validates_presence_of :name, :message => "论坛名称不能为空！"
  
  
end

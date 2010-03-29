class Topic < ActiveRecord::Base
  
  has_many :posts, :dependent => :destroy
  belongs_to :user, :counter_cache => true
  belongs_to :forum, :counter_cache => true
  
  validates_presence_of :title, :message => "标题不能为空！"
  
  
  
  def self.per_page
    10
  end

end

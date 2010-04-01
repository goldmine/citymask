class Post < ActiveRecord::Base

  belongs_to :user, :counter_cache => true 
  belongs_to :topic, :counter_cache => true 
  
  validates_presence_of :body, :message => "内容不能为空！"
  
  def self.per_page
    10
  end
end

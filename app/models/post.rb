class Post < ActiveRecord::Base
  
  attr_reader :per_page
  @@per_page = 20
  
  belongs_to :user, :counter_cache => true 
  belongs_to :topic, :counter_cache => true 
  
  validates_presence_of :body, :message => "内容不能为空！"
end

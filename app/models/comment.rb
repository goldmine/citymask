class Comment < ActiveRecord::Base
  belongs_to :entry, :counter_cache => true
  belongs_to :user
  
  validates_presence_of :body, :message => "内容不能为空！" 
end

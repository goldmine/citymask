class Album < ActiveRecord::Base
  belongs_to :user, :counter_cache => true 
  has_many :photos
  
  validates_presence_of :name,  :message => "像册名称不能为空!"
end

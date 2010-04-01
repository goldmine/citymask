class Entry < ActiveRecord::Base
  has_many :comments
  belongs_to :user, :counter_cache => true 
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :body,  :message => "can't be blank"
  
  def self.per_page
    10
  end
  
  def self.recent_blogs
    Entry.find(:all,
               :limit => 10,
               :order => 'created_at DESC',
               :include => :user)
  end
  
end

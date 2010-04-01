class Photo < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :album, :counter_cache => true
  
  has_attachment :storage => :file_system, 
                 :resize_to => '640x480',
                 :thumbnails => { :thumb => '160x120', :tiny => '50>' }, 
                 :max_size => 5.megabytes,
                 :content_type => :image,
                 :processor => 'Rmagick'
  validates_as_attachment
  
  
  
  def self.recent_photos
    Photo.find(:all, :limit => 10, :order => 'created_at DESC', 
               :conditions => 'user_id is not null',  
               :include => :user
                )
  end 
end

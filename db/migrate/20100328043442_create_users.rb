class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :limit => 64, :null => false
      t.string :email, :limit => 128, :null => false
      t.string :hashed_password, :limit => 64
      t.boolean :enabled, :default => true, :null => false
      t.datetime :last_login_at
      t.integer :topics_count, :null => false, :default => 0
      t.integer :posts_count, :null => false, :default => 0
      t.string :blog_title
      t.boolean :enable_comments, :default => true, :null => false
      t.integer :entries_count, :null => false, :default => 0
      t.integer :albums_count, :null => false, :default => 0
      t.integer :photos_count, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

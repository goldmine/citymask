class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.integer :forum_id
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :posts_count, :null => false, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end

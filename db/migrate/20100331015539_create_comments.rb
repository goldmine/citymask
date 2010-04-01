class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :entry_id
      t.integer :user_id
      t.string :guest_name
      t.string :guest_email
      t.string :guest_url
      t.text :body
      
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

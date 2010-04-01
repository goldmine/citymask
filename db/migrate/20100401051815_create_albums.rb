class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.integer :user_id
      t.integer :photos_count, :null => false, :default => 0
      t.string :name
      t.text :description
      t.boolean :public, :default => true, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end

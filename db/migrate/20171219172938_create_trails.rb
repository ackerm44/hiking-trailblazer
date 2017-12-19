class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :name
      t.float :length
      t.text :highlights
      t.integer :region_id
    end
  end
end

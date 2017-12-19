class CreateHikersTrails < ActiveRecord::Migration
  def change
    create_table :hikers_trails do |t|
      t.integer :hiker_id
      t.integer :trail_id
    end
  end
end

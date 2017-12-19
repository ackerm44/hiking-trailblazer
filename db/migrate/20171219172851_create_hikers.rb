class CreateHikers < ActiveRecord::Migration
  def change
    create_table :hikers do |t|
      t.string :username
      t.string :password_digest
    end
  end
end

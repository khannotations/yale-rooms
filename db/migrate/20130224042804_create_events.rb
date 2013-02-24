class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :room_id
      t.integer :organization_id
      
      t.string :name
      t.string :room_number

      t.timestamps
    end
  end
end

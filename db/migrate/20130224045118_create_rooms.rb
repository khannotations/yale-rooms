class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :number
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

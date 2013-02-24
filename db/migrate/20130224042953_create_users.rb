class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :default => "Unknown user"
      t.string :college
      t.string :year
      t.string :email
      t.string :netid

      t.timestamps
    end
  end
end

class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name

      t.timestamps
    end

    create_table :organizations_users, :id => false do |t|
      t.references :organization, :user
    end

    add_index :organizations_users, [:organization_id, :user_id]
  end
end

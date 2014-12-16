class AddGoogleFieldsToUser < ActiveRecord::Migration
  def up
    add_column :users, :google_token, :string
    add_column :users, :google_id, :string
  end

  def down
    remove_column :users, :google_token
    remove_column :users, :google_id
  end
end

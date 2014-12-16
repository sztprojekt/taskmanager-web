class AddGoogleFieldsToUser < ActiveRecord::Migration
  def up
    add_column :users, :google_token, :string
    add_column :users, :google_id, :integer
  end
end

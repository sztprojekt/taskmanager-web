class AddGoogleSquanceEventId < ActiveRecord::Migration
  def up
    add_column :tasks, :event_id, :string
    add_column :tasks, :sequence, :integer
  end
end

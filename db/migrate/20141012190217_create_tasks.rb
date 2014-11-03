class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.datetime :completed_at
      t.column :status, :boolean, default: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end

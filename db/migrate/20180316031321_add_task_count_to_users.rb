class AddTaskCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tasks_count, :integer
  end
end

class AddTaskCountToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :tasks_count, :integer
  end
end

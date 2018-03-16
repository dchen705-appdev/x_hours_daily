class AddCategoryCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :categories_count, :integer
  end
end

class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.string :status
      t.integer :user_id
      t.integer :category_id

      t.timestamps

    end
  end
end

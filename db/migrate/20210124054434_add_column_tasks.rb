class AddColumnTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expiration_date, :date, default: Time.now, null: false
  end
end

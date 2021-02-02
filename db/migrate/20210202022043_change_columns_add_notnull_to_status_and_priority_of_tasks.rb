class ChangeColumnsAddNotnullToStatusAndPriorityOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :integer, default: "未", null: false
    change_column :tasks, :priority, :integer, default: "未", null: false
  end
end

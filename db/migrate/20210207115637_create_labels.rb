class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels do |t|
      t.string :name, default: "未設定", null: false

      t.timestamps
    end
  end
end

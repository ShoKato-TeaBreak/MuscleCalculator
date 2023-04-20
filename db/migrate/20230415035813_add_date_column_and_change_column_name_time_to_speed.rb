class AddDateColumnAndChangeColumnNameTimeToSpeed < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :date, :date
    add_column :workouts, :speed, :integer
    remove_column :workouts, :time, :integer
    remove_column :exercises, :time, :integer
  end
end

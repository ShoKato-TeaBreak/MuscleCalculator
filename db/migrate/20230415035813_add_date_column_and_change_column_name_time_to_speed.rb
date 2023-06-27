class AddDateColumnAndChangeColumnNameTimeToSpeed < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :date, :date
    add_column :workouts, :speed, :integer
    remove_column :workouts, :time, :integer
    remove_column_if_exists :exercises, :time, :integer
  end

  def remove_column_if_exists(table, column, type)
    remove_column(table, column, type) if column_exists?(table, column)
  end
end

class AddLevelColumnToWorkoutTabel < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :level, :string
  end
end

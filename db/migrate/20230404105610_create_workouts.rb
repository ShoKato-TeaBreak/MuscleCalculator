class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.integer :user_id #Workoutを投稿したユーザーID
      t.string :name #トレーニング項目名
      t.integer :sets #何セット目のトレーニングかを記録
      t.float :weight #トレーニングの重量
      t.integer :reps #1セットあたり何回持ち上げたか
      t.integer :time #1回持ち上げるのにかかる時間
      t.float :calories #1セットの消費カロリー

      t.timestamps
    end
  end
end

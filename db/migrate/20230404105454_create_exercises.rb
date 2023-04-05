class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name #エクササイズ名(トレーニング機器名)
      t.float :mets_high #高負荷時のMets値
      t.float :mets_middle #中負荷時のMets値
      t.float :mets_low #低負荷時のMets値

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name #ユーザー名
      t.string :email #ユーザーのメールアドレス
      t.float :height #身長
      t.float :weight #体重
      t.integer :age #年齢
      t.string :sex #年齢

      t.timestamps
    end
  end
end

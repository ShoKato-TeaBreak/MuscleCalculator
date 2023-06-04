class Workout < ApplicationRecord
    validates :user_id, presence: {message: "ログインしていません"}
    validates :date, presence: {message: "日付が入力されていません"}
    validates :name, presence: {message: "運動名が入力されていません"}
    validates :sets, presence: {message: "セット数が入力されていません"}
    validates :reps, presence: {message: "回数が入力されていません"}
    validates :weight, presence: {message: "重量が入力されていません"}
    validates :speed, presence: {message: "速度が入力されていません"}
    validates :level, presence: {message: "運動強度が選択されていません"}
    validates :calories, presence: {message: "入力項目に不備があります"}
    # belongs_to :user
    # belongs_to :exercise

    def start_time
      date
    end

end

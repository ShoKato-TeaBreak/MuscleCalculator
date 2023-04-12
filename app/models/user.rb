class User < ApplicationRecord
    has_secure_password

    validates :name, presence: {message: "名前が入力されていません"}, length: { maximum: 50, message: "名前は50文字以内で入力してください" }
    validates :email, presence: {message: "メールアドレスが入力されていません"}, uniqueness: {message: "入力されたメールアドレスは既に使われています"}, length: { maximum: 100, message: "メールアドレスは100文字以内で入力してください" }
    validates :height, presence: {message: "身長が入力されていません"}, format: { with: /\A\d{1,3}(\.\d{0,1})?\z/, numericality: {message: "身長は半角で入力してください"}, message: "身長は整数部分は3桁まで、小数点以下は1桁までの数値を入力してください(例:165.3)" }
    validates :weight, presence: {message: "体重が入力されていません"}, format: { with: /\A\d{1,3}(\.\d{0,1})?\z/, numericality: {message: "体重は半角で入力してください"}, message: "体重は整数部分は3桁まで、小数点以下は1桁までの数値を入力してください(例:57.4)" }
    validates :age, presence: {message: "年齢が入力されていません"}, length: { maximum: 1, maximum: 130, message: "年齢は1から130歳の間で入力してください" }
    validates :sex, presence: {message: "性別を男か女で入力してください"}, inclusion: {in: ['男','女'], message: "性別を男か女で入力してください"}, length: { maximum: 1, minimum: 1, message: "性別を男か女で入力してください"}

    validates :password, presence: {message: "パスワードが入力されていません"}, length: { minimum: 8, message: "パスワードは8文字以上で入力してください"}

end

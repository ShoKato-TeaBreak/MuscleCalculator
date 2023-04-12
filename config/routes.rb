Rails.application.routes.draw do

  get '/about' => 'pages#about'#アプリについての説明ページ
  root 'pages#top'#トップページ


  post 'users/sign_in' => 'users#sign_in'# ユーザーログイン処理
  get 'users/sign_in' => 'users#sign_in_form'#ユーザーログイン画面
  delete 'users/sign_out' => 'users#sign_out'#ユーザーログアウト処理

resources :users, only: [
  :new,      # ユーザの新規作成画面
  :create,   # ユーザの新規登録処理
  :show,     # ユーザの情報表示画面
  :edit,     # ユーザの情報編集画面
  :update,   # ユーザの情報更新処理
  :destroy   # ユーザの削除処理
]

  get 'exercises/index'#エクササイズ情報一覧画面
  get 'exercises/show'#ここのエクササイズの詳細表示画面

end

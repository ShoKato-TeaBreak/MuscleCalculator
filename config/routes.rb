Rails.application.routes.draw do

  root 'pages#top'#トップページ


  post 'users/sign_in' => 'users#sign_in'# ユーザーログイン処理
  get 'users/sign_in' => 'users#sign_in_form'#ユーザーログイン画面
  delete 'users/sign_out' => 'users#sign_out'#ユーザーログアウト処理

  get 'users/mypage' => 'users#mypage'#マイページへのルーティング
  get 'users/destroy' => 'users#user_destroy_form'#ユーザー消去のためのパスワード認証をするルーティング

  resources :users, only: [
    :new,      # ユーザの新規作成画面
    :create,   # ユーザの新規登録処理
    :show,     # ユーザの情報表示画面
    :edit,     # ユーザの情報編集画面
    :update,   # ユーザの情報更新処理
    :destroy   # ユーザの削除処理
  ]

  resources :exercises, only: [
    :index,#エクササイズ一覧画面
    :show#ここのエクササイズの詳細表示画面
  ]

  get 'workouts/calendar/year' => 'workouts#calendar_year'
  get 'workouts/calendar/month/:date' => 'workouts#calendar_month'
  get 'workouts/calendar/day/:date' => 'workouts#calendar_day'

  resources :workouts, only: [
    :index,#ユーザのワークアウト一覧画面
    :show,#ユーザのワークアウト詳細画面
    :new,#ユーザのワークアウト新規作成画面
    :create,#ユーザのワークアウト新規作成処理
    :edit,#投稿されたトレーニング編集画面
    :update,#投稿されたトレーニング編集処理
    :destroy#投稿されたトレーニング削除処理
  ]

end

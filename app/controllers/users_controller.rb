class UsersController < ApplicationController

#ログインログアウト機能-------------------------------------------------------------
  def sign_in_form
  end

  def sign_in
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/home")
    else
      flash[:email] = params[:email]
      flash[:error_message] = "メールアドレスまたはパスワードが間違っています"
      redirect_to "/users/sign_in_form"
    end
  end

  def sign_out
    Rails.logger.debug "Logging out..."
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

#ユーザー登録処理-------------------------------------------------------------------

  def new
    @user = User.new(
      name: flash[:name],
      email: flash[:email],
      height: flash[:height],
      weight: flash[:weight],
      age: flash[:age],
      sex: flash[:sex]
    )
  end

  def create
    @user = User.new(
      name: params[:user][:name], 
      email: params[:user][:email],
      height: params[:user][:height],
      weight: params[:user][:weight],
      age: params[:user][:age],
      sex: params[:user][:sex],
      password: params[:user][:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/home")
    else
      flash[:name] = params[:user][:name]
      flash[:email] = params[:user][:email]
      flash[:height] = params[:user][:height]
      flash[:weight] = params[:user][:weight]
      flash[:age] = params[:user][:age]
      flash[:sex] = params[:user][:sex]
      flash[:error_message] = @user.errors.messages
      redirect_to("/users/new")
    end
  end

  def show
    @user = User.find_by(id: @current_user.id)
    @workouts = Workout.where(user_id: @user.id).order(date: :desc)
    @workouts_today = Workout.where(date: Time.zone.now.all_day, user_id: @user.id)
    @workouts_this_month = Workout.where(user_id: @user.id, date: Time.zone.now.all_month)

    #今日のトレーニングのカロリーを計算
    @calories_today = 0
    if @workouts_today.present?
      @workouts_today.each do |workout|
        @calories_today += workout.calories
      end
    end

    #今月のトレーニングのカロリーを計算
    @calories_this_month = 0
    if @workouts_this_month.present?
      @workouts_this_month.each do |workout|
        @calories_this_month += workout.calories
      end
    end

  end

  def account
  end

  def edit
  end

  def delete
  end

end

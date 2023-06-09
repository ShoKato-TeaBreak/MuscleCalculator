class UsersController < ApplicationController

#ログインログアウト機能-------------------------------------------------------------
  def sign_in_form
  end

  def sign_in
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/users/mypage"
    else
      flash[:email] = params[:email]
      flash[:error_message] = "メールアドレスまたはパスワードが間違っています"
      redirect_to "/users/sign_in"
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
      redirect_to("/users/mypage")
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

  def mypage
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
    @calories_today = @calories_today.round(2);

    #今月のトレーニングのカロリーを計算
    @calories_this_month = 0
    if @workouts_this_month.present?
      @workouts_this_month.each do |workout|
        @calories_this_month += workout.calories
      end
    end
    @calories_this_month = @calories_this_month.round(2);
  end


  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: @current_user.id)
  end

  def update
    @user = User.find_by(id: @current_user.id)
    if params[:user][:change_password] == "1"
      if @user.authenticate(params[:user][:current_password])
        if params[:user][:password] == params[:user][:password_confirmation]
          
          # 新しいパスワードが空のまま送信されていないかを確認
          if params[:user][:password].present?
            # パスワードを含めたユーザ情報を更新
            if @user.update(user_params.except(:current_password, :change_password, :password_confirmation))
              flash[:notice] = "パスワードの変更をしました。"
              redirect_to @user;
            else
              @user.errors.add(:password, "パスワードの更新に失敗しました")
              flash[:error_message] = @user.errors.messages;
              render :edit;
            end

          # 空で送信されていた場合はメッセージを表示
          else
            @user.attributes = user_params.except(:current_password, :change_password, :password, :password_confirmation)
            @user.errors.add(:password, "新しいパスワードが入力されていません")
            flash[:error_message] = @user.errors.messages;
            render :edit;
          end
        else
          @user.attributes = user_params.except(:current_password, :change_password, :password, :password_confirmation)
          @user.errors.add(:password, "新しいパスワードと確認用パスワードが一致しません")
          flash[:error_message] = @user.errors.messages;
          render :edit;
        end
      else
        @user.attributes = user_params.except(:current_password, :change_password, :password, :password_confirmation)
        @user.errors.add(:password, "現在のパスワードが間違っています")
        flash[:error_message] = @user.errors.messages;
        render :edit
      end
    else
      if @user.update(user_params.except(:current_password, :change_password, :password, :password_confirmation))
        redirect_to @user, notice: '変更を保存しました'
      else
        flash[:error_message] = @user.errors.messages;
        render :edit;
      end
    end
  end
  
  private def user_params
    params.require(:user).permit(:name, :email, :height, :weight, :age, :sex, :current_password, :change_password, :password, :password_confirmation)
  end

  def user_destroy_form
    @user = User.find_by(id: @current_user.id)
  end

  def destroy
    @user = User.find(params[:id])

    # bcryptでパスワードを認証
    if @user.authenticate(params[:password])
      @user.workouts.destroy_all
      @user.destroy
      flash[:notice] = "アカウントを削除しました。"
      redirect_to root_path
    else
      flash[:notice] = "パスワードが間違っています。"
      flash[:error_message] = "パスワードが間違っています。"
      redirect_to "/users/destroy"  # パスワード確認画面へ遷移するなど適切な遷移先を指定
    end
  end

end

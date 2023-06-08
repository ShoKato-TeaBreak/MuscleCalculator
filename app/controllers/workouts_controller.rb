class WorkoutsController < ApplicationController

  #以下3つはcreateアクションとupdateアクションで利用する共通処理を関数化したもの---------------
  
  #入力されたトレーニング速度(Quick, Normal, Slow)に対して、それぞれ(2秒,3秒,5秒)返す関数
  def convert_speed_label_to_time(speed)
    case speed
    when 'Normal'
      return 3
    when 'Quick'
      return 2
    else
      return 5;
    end
  end

  #入力されたトレーニング強度(hight,middle,low)に応じてエクササイズのMets値を取得するメソッド
  def get_exercise_mets(exercise_name, workout_level)
    exercise = Exercise.find_by(name: exercise_name)
    puts "exercise: #{exercise.inspect}"
    #選択された運動強度によってmets値を変更
    case workout_level
    when 'Hard'
      return exercise.mets_high
    when 'Easy'
      return exercise.mets_low
    else
      return exercise.mets_middle
    end
  end

  #カロリー計算をする関数
  def calculate_calories(mets, user_id, reps, time)

    #ユーザーの体重を取得
    weight = User.find_by(id: user_id).weight
    #トレーニングのカロリーを計算
    calories = mets * weight * ((reps * time) / 3600.0) * 1.05
  end

  #-----------------------------------------------------------------------------------

  def index
    @workouts = Workout.all
  end

  def new
    @workout = Workout.new(
      name: params[:name],
      sets: flash[:sets],
      weight: flash[:weight],
      reps: flash[:reps],
      speed: flash[:speed],
      level: flash[:level],
      date: params[:date]
    )
    @workouts_this_day = Workout.where(date: params[:date], user_id: @current_user.id)
    @exercises = Exercise.all

    @calories_this_day = 0
    if @workouts_this_day.present?
      @workouts_this_day.each do |workout|
        @calories_this_day += workout.calories
      end
    end
    @calories_this_day = @calories_this_day.round(2)
  end

  def create
    
    #運動の種類と運動強度に応じてmets値を取得する
    mets = get_exercise_mets(params[:workout][:name], params[:workout][:level])
    #入力されたトレーニング速度(Quick,Normal,Slow)を秒数に変換する
    time = convert_speed_label_to_time(params[:workout][:speed])
    #caluculate_calories関数にパラメータとしてメッツ値、ユーザーID、回数、トレーニング速度を渡して消費カロリーの計算をする
    calories = calculate_calories(mets, @current_user.id, params[:workout][:reps].to_i, time)

    @workout = Workout.new(
      user_id: @current_user.id,
      date: params[:workout][:date],
      name: params[:workout][:name],
      sets: params[:workout][:sets],
      weight: params[:workout][:weight],
      reps: params[:workout][:reps],
      speed: params[:workout][:speed],
      level: params[:workout][:level],
      calories: calories.round(2)
    )
    if @workout.save
      flash[:notice] = "トレーニングを記録しました"
    else
      flash[:sets] = params[:workout][:sets]
      flash[:weight] = params[:workout][:weight]
      flash[:reps] = params[:workout][:reps]
      flash[:speed] = params[:workout][:speed]
      flash[:level] = params[:workout][:level]
      flash[:error_message] = @workout.errors.messages
    end

    redirect_to new_workout_path(name: params[:workout][:name], date: params[:workout][:date])

  end

  def show
    @workout = Workout.find(params[:id])
  end

  def calendar_year

    #カレンダーの表示月を取得。デフォルトは今月から1年前まで。
    if params[:date].blank?
      @end_month = Date.today.end_of_month
    else
      @end_month = Date.parse(params[:date]).end_of_month
    end

    #1年間分のトレーニングを取得
    @workouts = Workout.where(date: (@end_month - 11.months).beginning_of_month..@end_month, user_id: @current_user.id )
  end

  def calendar_month
    #カレンダーの表示月を取得。
    @target_month = Date.parse(params[:date])
    #1ヶ月分のトレーニングを取得
    @workouts_this_month = Workout.where(date: @target_month.beginning_of_month..@target_month.end_of_month, user_id: @current_user.id)

    #1ヶ月分ののトレーニング消費カロリーを計算
    @calories_this_month = 0
    if @workouts_this_month.present?
      @workouts_this_month.each do |workout|
        @calories_this_month += workout.calories
      end
    end
    @calories_this_month = @calories_this_month.round(2)
  end

  def calendar_day
    #カレンダーの表示日を取得。
    @target_day = Date.parse(params[:date])
    #トレーニング項目の取得をする
    @exercises = Exercise.all
    
    #1日分のトレーニングを取得
    @workouts_this_day = Workout.where(date: @target_day, user_id: @current_user.id)

    #1日分ののトレーニング消費カロリーを計算
    @calories_this_day = 0
    if @workouts_this_day.present?
      @workouts_this_day.each do |workout|
        @calories_this_day += workout.calories
      end
    end
    @calories_this_day = @calories_this_day.round(2)
  end


  def edit
    @workout = Workout.find(params[:id])
    @exercises = Exercise.all
  end

  def update
    @workout = Workout.find(params[:id])
    
    #運動の種類と運動強度に応じてmets値を取得する
    mets = get_exercise_mets(params[:workout][:name], params[:workout][:level])
    #入力されたトレーニング速度(Quick,Normal,Slow)を秒数に変換する
    time = convert_speed_label_to_time(params[:workout][:speed])
    #caluculate_calories関数にパラメータとしてメッツ値、ユーザーID、回数、トレーニング速度を渡して消費カロリーの計算をする
    calories = calculate_calories(mets, @current_user.id, params[:workout][:reps].to_i, time)

    if @workout.update(
      user_id: @current_user.id,
      date: params[:workout][:date],
      name: params[:workout][:name],
      sets: params[:workout][:sets],
      weight: params[:workout][:weight],
      reps: params[:workout][:reps],
      speed: params[:workout][:speed],
      level: params[:workout][:level],
      calories: calories.round(2)
    )
      flash[:notice] = "トレーニングを更新しました"
      redirect_to "/workouts/calendar/day/#{params[:workout][:date]}"
    else
      flash[:error_message] = @workout.errors.messages
      redirect_to edit_workout_path(@workout)
    end
  end
    

  def destroy
    @workout = Workout.find(params[:id])
    date = @workout.date
    @workout.destroy
    flash[:notice] = "トレーニングを削除しました"
    redirect_to "/workouts/calendar/day/#{date}"
  end
end

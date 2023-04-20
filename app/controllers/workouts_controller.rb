class WorkoutsController < ApplicationController
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
    @workout_today = Workout.where(date: Time.zone.now.all_day, user_id: @current_user.id)
    @exercises = Exercise.all
  end

  def create
    exercise = Exercise.find_by(name: params[:workout][:name])
    puts "exercise: #{exercise.inspect}"
    #選択された運動強度によってmets値を変更
    case params[:workout][:level]
    when 'high'
      mets = exercise.mets_high
    when 'low'
      mets = exercise.mets_low
    else
      mets = exercise.mets_middle
    end
    puts "mets: #{mets}"
    #ユーザーの体重を取得
    weight = User.find_by(id: @current_user.id).weight
    puts "weight: #{weight}"
    reps = params[:workout][:reps].to_i
speed = params[:workout][:speed].to_i
puts "reps: #{reps}, speed: #{speed}"
    #トレーニングのカロリーを計算
    calories = mets * weight * ((params[:workout][:reps].to_i * params[:workout][:speed].to_i) / 3600.0) * 1.05
    puts "calories: #{calories}"
    @workout = Workout.new(
      user_id: @current_user.id,
      date: params[:workout][:date],
      name: params[:workout][:name],
      sets: params[:workout][:sets],
      weight: params[:workout][:weight],
      reps: params[:workout][:reps],
      speed: params[:workout][:speed],
      level: params[:workout][:level],
      calories: calories.round(3)
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

  def destroy
    @workout = Workout.find(params[:id])
    puts "workout: #{@workout.inspect}"
    puts "workout: #{params[:id]}"
    @workout.destroy
    flash[:notice] = "トレーニングを削除しました"
    redirect_to determine_redirect_path #呼び出し元のURLによってリダイレクト先を変更
  end

  #呼び出し元のURLによってリダイレクト先を変更
  #editアクションとdestroyアクションで利用する
  def determine_redirect_path
    referrer = params[:referrer]
    puts "呼び出し元のURL情報 : referrer: #{referrer}"
    if referrer.include?(new_workout_path)
      new_workout_path
    else
      workouts_path
    end
  end
end

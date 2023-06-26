class ApplicationController < ActionController::Base

    before_action :set_current_user;
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found;

    private

    #ユーザーがログイン中かを確認するメソッド
    def authenticate_user!
        if @current_user.nil?
            redirect_to "/users/sing_in_form", notice: "ログインが必要です"
        end
    end

    #ログイン中のユーザーがアクセスできないページを指定するメソッド
    def forbid_login_user!
        if @current_user
            redirect_to root_path, notice: "すでにログインしています"
        end
    end

    #ログイン中のユーザを@current_userにセットする
    def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    end

    #DBにアクセスした際にレコードが見つからなかった時用の処理
    # def record_not_found
    #     render plain: "404 Not Found", status: 404
    # end


end

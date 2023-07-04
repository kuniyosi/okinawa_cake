# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # ↓ログイン機能が実行される前に実行する
  before_action :reject_inactive_customer, only: [:create]

  # 退会しているかを判断するメソッド。入力された情報とデータベースの会員情報を照らし合わせstatusがfalseの場合、ログインができない。
  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && !@customer.status
        flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
        redirect_to new_customer_session_path
      end
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

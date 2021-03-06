class SessionsController < ApplicationController
  # ゲストユーザー作成
  def new_guest
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストユーザーとしてログインしました。'
  end
end

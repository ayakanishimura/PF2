require 'rails_helper'

describe 'ユーザーの新規登録のテスト' do
  context '新規登録成功のテスト' do
    before do
      visit new_user_registration_path
      byebug
      fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end
    it '正しく新規登録される' do
      expect { click_button '新規登録' }.to change { User.count }.by(1)
    end
  end
end
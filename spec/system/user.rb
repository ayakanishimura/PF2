require 'rails_helper'

describe 'ユーザーの新規登録のテスト' do
    before do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end
    it '正しく新規登録される' do
      expect { click_button '新規登録' }.to change { User.count }.by(1)
    end
end

describe 'ユーザーのログインのテスト' do
  let(:user) { create(:user) }

  context 'ログイン成功のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    after do
      click_link 'ログアウト'
    end

    it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
      expect(current_path).to eq '/users/' + user.id.to_s
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/users/sign_in'
    end
  end
end







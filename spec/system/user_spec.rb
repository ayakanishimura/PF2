require 'rails_helper'

describe 'ユーザーの新規登録のテスト' do
  before do
    visit new_user_registration_path
    fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
    fill_in 'user[email]', with: Faker::Internet.email
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
  end

  it '正しく新規登録される' do
    expect { click_button '新規登録' }.to change(User, :count).by(1)
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

describe 'ユーザログアウトのテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    logout_link = find_all('a')[4].native.inner_text
    logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
    click_link logout_link
  end

  context 'ログアウト機能のテスト' do
    it '正しくログアウトできている: ログアウト後のリダイレクト先が、トップになっている' do
      expect(current_path).to eq '/'
    end
  end
end

describe '自分のユーザ情報編集画面のテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    visit edit_user_path(user)
  end

  context '表示の確認' do
    it '名前編集フォームに自分の名前が表示される' do
      expect(page).to have_field 'user[name]', with: user.name
    end
    it '自己紹介編集フォームに自分の自己紹介文が表示される' do
      expect(page).to have_field 'user[introduction]', with: user.introduction
    end
  end

  context '更新成功のテスト' do
    before do
      @user_old_name = user.name
      @user_old_intrpduction = user.introduction
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
      click_button '変更する'
    end

    it 'nameが正しく更新される' do
      expect(user.reload.name).not_to eq @user_old_name
    end
    it 'introductionが正しく更新される' do
      expect(user.reload.introduction).not_to eq @user_old_intrpduction
    end
  end
end

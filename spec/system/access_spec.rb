require 'rails_helper'

describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
  subject { current_path }

  let(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  it 'ユーザ一覧画面' do
    visit users_path
    is_expected.to eq '/users/sign_in'
  end
  it 'ユーザ詳細画面' do
    visit user_path(user)
    is_expected.to eq '/users/sign_in'
  end
  it 'ユーザ情報編集画面' do
    visit edit_user_path(user)
    is_expected.to eq '/users/sign_in'
  end
  it '投稿一覧画面' do
    visit articles_path
    is_expected.to eq '/users/sign_in'
  end
  it '投稿詳細画面' do
    visit article_path(article)
    is_expected.to eq '/users/sign_in'
  end
  it '投稿編集画面' do
    visit edit_article_path(article)
    is_expected.to eq '/users/sign_in'
  end
end

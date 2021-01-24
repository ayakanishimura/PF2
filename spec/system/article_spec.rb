require 'rails_helper'

describe '新規投稿のテスト', type: :system do
    let(:user){ create(:user)}

    def sign_in
      visit '/users/sign_in'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context '投稿成功のテスト' do
      it '自分の新しい投稿が正しく保存される' do
        sign_in
        visit new_article_path
        fill_in 'article[title]', with: "test_title"
        fill_in 'article[body]', with: "test_body"
        expect { click_on '投稿' }.to change { Article.count }.by(1)
        expect(current_path).to eq '/articles'
      end
    end

    context '編集のテスト' do
      it '自分の投稿が正しく編集される' do
        sign_in
        article_1 = FactoryBot.create(:article)
        visit edit_article_path(article_1)
        fill_in 'article[title]', with: "test_title_edit"
        fill_in 'article[body]', with: "test_body_edit"
        click_on '保存'
        expect(page).to have_content 'test_title_edit'
      end
    end

    context '削除のテスト' do
      it '自分の投稿が正しく削除される' do
        sign_in
        article_1 = FactoryBot.create(:article, user: user)
        visit article_path(article_1)
        expect { find(".delete-btn").click }.to change { Article.count }.by(-1)
      end
    end
end


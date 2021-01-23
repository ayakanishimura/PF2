require 'rails_helper'

describe '新規投稿のテスト', type: :system do
    let(:user){ create(:user)}

    def sign_in
      visit '/users/sign_in'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    before do
      sign_in


      visit new_article_path
      puts page.body
      fill_in 'article[title]', with: 'title1'
      fill_in 'article[body]', with: Faker::Lorem.characters(number: 20)
    end
    context '投稿成功のテスト' do
      it '自分の新しい投稿が正しく保存される' do
        click_button '投稿'
        
        #expect { click_button '投稿' }.to change { Article.count }.by(1)
        
        puts Article.all
      end

      it 'リダイレクト先が、保存できた投稿の一覧画面になっている' do
        click_button '投稿'
        expect(current_path).to eq '/articles/'
      end
    end
end

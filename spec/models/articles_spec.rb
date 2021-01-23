require 'rails_helper'

RSpec.describe 'Articleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @article = build(:article)
      @user = build(:user)
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        @article.title = ''
        @article.valid? # false or true
        expect(@article.errors.messages[:title]).to include("can't be blank")
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        @article.body = ''
        @article.valid?
        expect(@article.errors.messages[:body]).to include("can't be blank")
      end
    end
  end
end
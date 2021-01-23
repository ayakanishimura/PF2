require 'rails_helper'

RSpec.describe 'Articleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @article = build(:article)
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        article.title = ''
        is_expected.to eq false
      end
    end

    context 'bodyカラム' do
      it '空欄でないこと' do
        book.body = ''
        is_expected.to eq false
      end
    end
  end
end
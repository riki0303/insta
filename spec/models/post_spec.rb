require 'rails_helper'

RSpec.describe Post, type: :model do
  # :userはfactorybotにより定義
  let!(:user) { create(:user) }

  context 'タイトルが入力されてる場合' do
    let!(:post) { build(:post, user: user) }

    it '記事を保存出来る' do
      expect(post).to be_valid
    end
  end

  context 'タイトルが入力されていない場合' do
    let!(:post) { build(:post, title: '', user: user) }

    before do
      post.save
    end

    it '記事を保存出来ない' do
      expect(post.errors.messages[:title][0]).to eq('を入力してください')
    end
  end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) do
    user = User.create! ({
    email: 'test@example.com',
    password: 'password',
    account: 'account'
    })
  end

  context 'タイトルが入力されてる場合' do
    let!(:post) do
      user.posts.build({
        title: Faker::Lorem.characters(number: 10)
      })
    end

    it '記事を保存出来る' do
      expect(post).to be_valid
    end
  end


  context 'タイトルが入力されていない場合' do
    let!(:post) do
      user.posts.create({
        title: ''
      })
    end

    it '記事を保存出来ない' do
      expect(post.errors.messages[:title][0]).to eq('を入力してください')
      
    end
  end
end

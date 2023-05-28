require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'タイトルが入力されていれば、記事を保存できる' do
    user = User.create! ({
      email: 'test@example.com',
      password: 'password',
      account: 'account'
    })

    post = user.posts.build({
      title: Faker::Lorem.characters(number: 10)
    })

    expect(post).to be_valid
  end
end

require 'rails_helper'

RSpec.describe 'Post', type: :system do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, user: user) }

  before do
    eyecatch_image = fixture_file_upload('test.jpg')
    posts.each do |post|
      post.eyecatches.attach(eyecatch_image)
    end
  end

  it '記事一覧が表示される' do
    visit root_path

    posts.each do |post|
      expect(page).to have_css('.post__title', text: post.title)
      expect(page).to have_css('.post__eyecatch-container') do |container|
        expect(container).to have_css('img')
      end
    end
  end

  it '記事詳細が表示できる' do
    visit root_path
    first('.post__eyecatch-container').click

    expect(page).to have_css('.post__title', text: Post.first.title)
  end
end

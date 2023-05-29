require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comments) { create_list(:comment, 3, post: post, user: user) }

  describe 'GET /comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '200 Status' do
        get new_post_comment_path(post_id: post.id)
        expect(response).to have_http_status(200)
        binding.pry
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面へリダイレクト' do
        get post_comments_path(post_id: post.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

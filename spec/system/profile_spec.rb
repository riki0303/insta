require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let(:user) { create(:user, :with_profile) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it '自分のプロフィールページを表示出来る' do
      visit profile_path
      expect(page).to have_css('.profile__name', text: user.profile.name )
    end
  end

end
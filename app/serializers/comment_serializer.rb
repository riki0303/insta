# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :user_account, :user_avatar

  def user_account
    object.user.account
  end

  def user_id
    object.user.id
  end

  def user_avatar
    if object.user.profile.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_path(object.user.profile.avatar, only_path: true)
    else
      ActionController::Base.helpers.asset_path('default-avatar')
    end
  end
end

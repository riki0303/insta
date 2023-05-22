class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content,:user_id, :user_account, :user_avatar

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

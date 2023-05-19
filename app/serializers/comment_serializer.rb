class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_account



  def user_account
    object.user.account
  end
end

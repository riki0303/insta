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
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, presence: true

  after_create :send_mention_emails


  private

  def mentioned_users
    mentioned_accounts = content.scan(/@(\w+)/).flatten
    User.where(account: mentioned_accounts)
  end

  def send_mention_emails
    users = mentioned_users

    users.each do |user|
      CommentMailer.mention_notification(user, content).deliver_later
    end
  end
end

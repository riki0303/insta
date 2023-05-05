# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account               (account) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 中間テーブルとの関係（自分が相手をフォローする時）
  has_many :following_relationsips, foreign_key: 'follower_id', class_name: 'Relationship' , dependent: :destroy
  # 中間テーブルをまたいでfollowingを取得
  has_many :followings, through: :following_relationsips, source: :following

  has_many :follower_relationtips, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationtips, source: :follower

  def has_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  def follow!(user)
    following_relationsips.create!(following_id: user.id)
  end

  def unfollow!(user)
    relation = following_relationsips.find_by!(following_id: user.id)
    relation.destroy!
  end
end

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
  end
end

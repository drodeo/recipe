require 'rails_helper'

describe Recipe , type: :model do
  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:owner) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:short) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:owner_id) }
  it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(5) }
  it { is_expected.to have_db_index(:user_id) }
end


# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  name               :string
#  short              :string
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  user_id            :integer
#  owner_id           :integer
#  love_id            :integer          default(0)
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#

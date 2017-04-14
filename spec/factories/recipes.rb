FactoryGirl.define do
  factory :recipe do
    name "MyString"
    short "MyString"
    description "MyText"
  end
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
#  owner_id           :integer
#  love_id            :integer          default(0)
#

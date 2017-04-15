class Recipe < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :user
  has_many :comments
  has_attached_file :image, styles: { small: "100x100", med: "280x235", large: "500x500" },
                             url: "/system/:hash.:extension",
                             hash_secret: "very_secret_hash_here"
 
  acts_as_commentable

  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /JPE?G\Z/ ]
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
                               size: { in: 0..6500.kilobytes }

  validates :name, :short, :description, presence: true
  validates :owner_id, presence: true

  validates :name, length: { minimum: 5 }
  #scope :my, -> { where(owner_id: owner_id) }

  acts_as_taggable

  def owner
    User.find(self.owner_id)
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
#  user_id            :integer
#  owner_id           :integer
#  love_id            :integer          default(0)
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#

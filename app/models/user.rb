class User < ActiveRecord::Base
  rolify
  after_create :assign_default_role
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable,  :validatable, :omniauthable

  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_and_belongs_to_many :groups
  has_many :recipes, foreign_key: "owner_id"

  has_many :active_relationships,  class_name:  "Following",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Following",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_attached_file :avatar, styles: { small: "100x100", med: "280x235", large: "500x500" },
                             url: "/system/:hash.:extension",
                             hash_secret: "very_secret_hash_here"

  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /JPE?G\Z/ ]
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
                               size: { in: 0..6500.kilobytes }
  
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id) unless other_user.eql?(self)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def email_required?
    false
  end

  def toggle_group(group)
    groups.find_by(id: group.id) ? groups.delete(group.id) : groups << group
  end

  def joined_purchase?(purchase)
    purchases.include?(purchase)
  end

  def join_purchase(purchase)
    purchases << purchase unless joined_purchase?(purchase)
  end

  def leave_purchase(purchase)
    purchases.delete(purchase.id) if joined_purchase?(purchase)
  end

  def self.from_omniauth(auth)
    attributes = { email: auth.info.email, password: Devise.friendly_token[0,20],
                   username: auth.info.name, provider: auth.provider, uid: auth.uid }
    user = where(attributes.slice(:provider, :uid)).first
    user.nil? ? create(attributes) : user
  end

  #Return full user name or email
  def name
    username || email
  end

  #Get user avatar from gravatar.com
  def gravatar
    if self.avatar_file_name.nil?
      mail = email || "#{provider}_#{uid}"
      hash = Digest::MD5.hexdigest(mail)
      "http://www.gravatar.com/avatar/#{hash}?d=identicon"
    else
      self.avatar  
    end  
  end

  def author_of?(entity)
    id == entity.owner_id
  end

  private

  def assign_default_role
    self.add_role :user
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  role_id                :integer
#  phone                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

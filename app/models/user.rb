class User < ApplicationRecord
  before_destroy :admin_user_destroy_action
  before_update :admin_user_update_action
  mount_uploader :icon, IconUploader
  has_many :articles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

    #指定のユーザをフォローする
  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end
  #フォローしているかどうかを確認する
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end
  #指定のユーザのフォローを解除する
  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  private

    def admin_user_destroy_action
      if User.where(admin: true).count == 1 && self.admin
        throw(:abort)
      end
    end

    def admin_user_update_action
      @admin_user = User.where(admin: true)
      if (@admin_user.count == 1 && @admin_user.first == self) && !(self.admin)
        throw :abort

      end
    end
end

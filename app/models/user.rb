class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, class_name: 'Post', foreign_key: 'author_id', dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id', dependent: :destroy
  has_many :likes, class_name: 'Like', foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  # User::Roles
  # The available roles
  ROLES = %w[admin].freeze

  ROLES.each do |exact_role|
    define_method "#{exact_role}?" do
      role == exact_role
    end
  end
end

class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                 foreign_key: "followed_id",
                                 dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  mount_uploader :avatar, AvatarUploader
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: Settings.user.name.is_presence,
                  length: {minimum: Settings.user.name.min_size,
                          maximum: Settings.user.name.max_size}
  validates :email, presence: Settings.user.email.is_presence,
                    uniqueness: Settings.user.email.is_unique,
                    format: {with: VALID_EMAIL_REGEX},
                    length: {maximum: Settings.user.email.max_size}
  validates :password, presence: Settings.user.password.is_presence,
                      allow_blank: Settings.user.password.is_allow_blank,
                      length: {minimum: Settings.user.password.min_size,
                              maximum: Settings.user.password.max_size}
  validates :avatar, presence: Settings.user.avatar.is_presence,
                    allow_blank: Settings.user.avatar.is_allow_blank
  validate :avatar_size
  before_save :downcase_email
  before_create :create_activation_digest

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def password_reset_expired?
    reset_at < Settings.reset_pass_expered_in_hour.hours.ago
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token), reset_at: Time.zone.now
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def avatar_size
    if avatar.size > Settings.user.avatar.max_size_in_MB.megabytes
      errors.add :avatar, I18n.t("should_be_less_than_x_unit", x: Settings.user.avatar.max_size_in_MB, unit: Settings.user.avatar.unit)
    end
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end

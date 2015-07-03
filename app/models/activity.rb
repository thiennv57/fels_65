class Activity < ActiveRecord::Base
  belongs_to :user
  scope :recent, ->{order Settings.activity.recent}
  scope :followed, ->(user){where("user_id IN (?) OR user_id = ?",
    user.following.select("user_id"), user.id).order created_at: :desc}
end

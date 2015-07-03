class Lesson < ActiveRecord::Base
  included ActivityLog

  belongs_to :user
  belongs_to :user
  belongs_to :category
  belongs_to :category
  has_many :results, dependent: :destroy
 end

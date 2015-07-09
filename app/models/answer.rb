class Answer < ActiveRecord::Base
  belongs_to :word
  has_one :result, dependent: :destroy
  validates :mean, presence: Settings.answer.mean.is_presence
  scope :mean_ordered, ->{order "mean COLLATE NOCASE ASC"}
end

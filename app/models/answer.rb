class Answer < ActiveRecord::Base
  belongs_to :word
  validates :mean, presence: Settings.answer.mean.is_presence
end

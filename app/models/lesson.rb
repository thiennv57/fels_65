class Lesson < ActiveRecord::Base
  include ActivityLogs

  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :results
  after_save :save_activity
  def num_of_correct_ans
    self.results.select{|result| result.answer.is_correct}.sum
  end

  def save_activity
    create_activity user_id, id, Settings.activities.learned
  end
end

class Lesson < ActiveRecord::Base
  included ActivityLog

  belongs_to :user
  belongs_to :user
  belongs_to :category
  belongs_to :category
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :results

  def num_of_correct_ans
    self.results.select{|result| result.answer.is_correct}.sum
  end
end

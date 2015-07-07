class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true,
      reject_if: proc { |a| a[:mean].blank? }
  validates :word, presence: Settings.word.word.is_presence

  scope :in_category, ->category{where category_id: category.id if category.id.present?}
  scope :learned, ->user{where("id IN (
    SELECT word_id FROM results WHERE lesson_id IN ( SELECT id FROM lessons WHERE user_id = ?
      ))",user.id)}
  scope :not_learned, ->user{where("id NOT IN (
    SELECT word_id FROM results WHERE lesson_id IN ( SELECT id FROM lessons WHERE user_id = ?
      ))",user.id)}
end

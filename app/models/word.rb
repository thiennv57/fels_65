class Word < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers, allow_destroy: true,
      reject_if: proc { |a| a[:mean].blank? }
  validates :word, presence: Settings.word.word.is_presence

  scope :in_category, ->category_id{where category_id: category_id if category_id.present?}
  scope :learned, ->user{where("id IN (
    SELECT word_id FROM results WHERE lesson_id IN ( SELECT id FROM lessons WHERE user_id = ?
      ))",user.id)}
  scope :not_learned, ->user{where("id NOT IN (
    SELECT word_id FROM results WHERE lesson_id IN ( SELECT id FROM lessons WHERE user_id = ?
      ))",user.id)}
  scope :random_questions, ->{order "RANDOM() LIMIT #{Settings.lesson.question_limit_words}"}
  scope :word_ordered, ->{order "word COLLATE NOCASE ASC"}
  scope :get_all, ->user{}
end

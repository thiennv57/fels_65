class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy
  validates :name, length: {maximum: Settings.category.name.max_size}
  scope :name_ordered, ->{order "name COLLATE NOCASE ASC"}
end

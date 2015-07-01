class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy
  validates :name, length: {maximum: Settings.category.name.max_size}
end

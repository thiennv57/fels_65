class RemoveResultFromLesson < ActiveRecord::Migration
  def change
    remove_column :lessons, :result, :integer
  end
end

class RemoveIsCorrectFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :is_correct, :boolean
  end
end

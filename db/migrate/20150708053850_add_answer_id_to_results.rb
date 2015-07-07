class AddAnswerIdToResults < ActiveRecord::Migration
  def change
    add_reference :results, :answer, index: true, foreign_key: true
  end
end

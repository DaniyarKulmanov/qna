class RemoveTestFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_reference :questions, :test, null: false, foreign_key: true
  end
end

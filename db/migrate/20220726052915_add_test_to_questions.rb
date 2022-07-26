class AddTestToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :test, null: false, foreign_key: true
  end
end

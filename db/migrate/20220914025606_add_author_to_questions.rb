class AddAuthorToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :author, foreign_key: { to_table: :users }
    change_column_null :questions, :author_id, false
  end
end

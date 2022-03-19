class AddQuizToAnsweredQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :answered_questions, :quiz_id, :integer
    add_index :answered_questions, :quiz_id
  end
end

class AddAnsweredAtToAnsweredQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :answered_questions, :answered_at, :datetime
  end
end

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :description
      t.integer :points, default: 1
      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end

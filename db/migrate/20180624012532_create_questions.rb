class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.integer :book_id
      t.string :question
      t.string :answer
      t.boolean :starred
      t.integer :user_id

      t.timestamps
    end
  end
end

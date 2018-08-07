class CreateAnswerEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_events do |t|
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end

class AddQuestionQueue < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :question_queue, :text
  end
end

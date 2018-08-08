class CreatePageField < ActiveRecord::Migration[5.1]

  class Question < ActiveRecord::Base
  end

  def change
    add_column :questions, :page, :integer
    Question.reset_column_information
    Question.all.each do |q|
      answer_parts = q.answer.split(' p')
      answer = answer_parts[0...-1].join(' p')
      page = answer_parts[-1].to_i
      if page == 0
        answer += ' p' + answer_parts[-1]
      else
        q.page = page
      end
      q.answer = answer
      q.save
    end
  end
end

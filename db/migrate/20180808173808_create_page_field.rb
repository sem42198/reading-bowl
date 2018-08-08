class CreatePageField < ActiveRecord::Migration[5.1]

  class Question < ActiveRecord::Base
  end

  def change
    add_column :questions, :page, :integer
    Question.reset_column_information
    Question.all.each do |q|
      answer_parts = q.answer.split(' p')
      next unless answer_parts.size > 1
      page = answer_parts[-1].to_i
      next if page == 0
      q.answer = answer_parts[0...-1].join(' p')
      q.page = page
      q.save
    end
  end
end

class Book < ApplicationRecord

  has_many :questions
  has_many :read_events

  accepts_nested_attributes_for :questions

  validates_uniqueness_of :title, :scope => [:author]

  validates :title, :presence => true
  validates :author, :presence => true

  def answer_events
    events = []
    AnswerEvent.all.each do |ans|
      events.push(ans) if Question.find(ans.question_id).book_id == id
    end
    events
  end

  def top_students(num = 0)
    num -=1
    User.students.sort_by {|s| -s.questions_answered(self)}[0..num]
  end
end

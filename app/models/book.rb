class Book < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :read_events, dependent: :destroy
  has_many :readers, through: :read_events
  has_many :answer_events, through: :questions

  accepts_nested_attributes_for :questions

  validates_uniqueness_of :title, scope: [:author]

  validates :title, presence: true
  validates :author, presence: true


  def top_students(num = 0)
    num -= 1
    User.students.sort_by { |s| -s.questions_answered(self) }[0..num]
  end
end
